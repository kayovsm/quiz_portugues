import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_portugues/app/ui/widgets/common/utils/util_formatter_common.dart';

class FirebaseService {
  final FirebaseFirestore firestore =
      FirebaseFirestore.instance; // instancia do FirebaseFirestore

  // salva os resultados do usuário no firestore
  Future<void> saveResult(
      int correctAnswers, int totalTime, String name) async {
    // obtem o usuario atual
    User user = FirebaseAuth.instance.currentUser!;

    // referencia ao documento do usuario no firestore
    DocumentReference userDoc = firestore.collection('ranking').doc(user.uid);

    // formata o tempo total em uma string
    String formattedTime = UtilFormatterCommon.formatDurationToTimeString(
        totalTime);

    userDoc.get().then((doc) {
      // verifica se o documento do usuario ja existe
      if (doc.exists) {
        // obtem o numero de respostas corretas salvas
        int savedCorrectAnswers = doc['correctAnswers'];

        // obtem o tempo salvo
        String savedTime = doc['time'];

        // verifica se a nova quantidade de acertos é melhor que o salvo
        bool isUpperCorrectAnswersToSaved =
            correctAnswers >= savedCorrectAnswers;
        // verifica se o novo tempo é melhor que o salvo
        bool isUpperTimeToSaved = totalTime <
            UtilFormatterCommon.convertTimeStringToSeconds(savedTime);

        // verifica se o novo resultado é melhor que o salvo
        if (isUpperCorrectAnswersToSaved || isUpperTimeToSaved) {
          // atualiza o documento do usuario no firestore
          userDoc.set({
            'correctAnswers': correctAnswers,
            'time': formattedTime,
            'name': name,
          });
        }
      } else {
        // cria um novo documento para o usuario no firestore
        userDoc.set({
          'correctAnswers': correctAnswers,
          'time': formattedTime,
          'name': name,
        });
      }
    });
  }

  // função para adicionar 10 usuários de teste
  Future<void> addUsersTest() async {
    final List<Map<String, dynamic>> testUsers = List.generate(10, (index) {
      return {
        'name': 'Test User ${index + 1}',
        'correctAnswers': (index + 1) * 2, // exemplo de pontuação
        'time': UtilFormatterCommon.formatDurationToTimeString(
            (index + 1) * 10), // exemplo de tempo formatado
      };
    });

    // adiciona cada usuario de teste ao firestore
    for (var user in testUsers) {
      await firestore.collection('ranking').add(user);
    }
  }
}
