import 'dart:async';
import 'package:get/get.dart';
import 'package:quiz_portugues/app/data/database/user_db.dart';
import '../core/services/firebase_service.dart';
import '../data/database/questions_db.dart';
import '../data/models/question_model.dart';
import '../routes/routes.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

/// CONTROLADOR PARA GERENCIAR O ESTADO E A LÓGICA DO QUIZ DE TORNEIO.
class ChallengeController extends GetxController
    with GetTickerProviderStateMixin {
  final QuestionsDB dbHelper = QuestionsDB();
  late Future<List<QuestionModel>> questionsFuture;
  final FirebaseService firebaseService = FirebaseService();

  var currentQuestionIndex = 0.obs; // indice da pergunta atual
  var questionCounter = 1.obs; // contador de perguntas
  var errors = 0.obs; // contador de erros
  var correctAnswers = 0.obs; // contador de respostas corretas
  var skippedQuestions = 0.obs; // contador de perguntas puladas
  var selectedAnswer = (-1).obs; // índice da resposta selecionada
  var selectedQuestions =
      <QuestionModel>[].obs; // lista de perguntas selecionadas
  late Stopwatch stopwatch; // cronometro
  var elapsedTime = const Duration().obs; // tempo decorrido

  // INICIALIZA O CONTROLADOR
  @override
  void onInit() {
    super.onInit();

    // inicializa o plugin do cronometro
    stopwatch = Stopwatch()..start();

    // inicializa o banco de dados
    dbHelper.initializeDatabase().then((_) {
      questionsFuture = dbHelper.getQuestions();
    });

    // carrega perguntas do arquivo JSON
    loadQuestionsFromJson().then((questions) {
      selectedQuestions.value = questions.take(18).toList();

      for (var question in selectedQuestions) {
        int correctAnswerIndex = question.correctAnswerIndex;
        List<String> options = question.options.cast<String>();
        String correctAnswer = options[correctAnswerIndex - 1];

        // embaralha as opoes e atualiza o índice da resposta correta
        options.shuffle();
        int newCorrectAnswerIndex = options.indexOf(correctAnswer) + 1;

        // atualiza os dados da pergunta
        question.correctAnswerIndex = newCorrectAnswerIndex;
        question.options = options;
      }

      // inicia o cronometro
      Timer.periodic(const Duration(seconds: 1), (timer) {
        elapsedTime.value = stopwatch.elapsed;
      });
    });
  }

  // FINALIZA O CONTROLADOR
  @override
  void onClose() {
    stopwatch.stop();
    // animationController.dispose();
    super.onClose();
  }

  Future<List<QuestionModel>> loadQuestionsFromJson() async {
    // Carrega o arquivo JSON
    String jsonString =
        await rootBundle.loadString('assets/json/questions.json');
    List<dynamic> jsonResponse = json.decode(jsonString);

    // Converte o JSON para uma lista de objetos Question
    return jsonResponse
        .map((question) => QuestionModel.fromJson(question))
        .toList();
  }

  /// PULA A PERGUNTA ATUAL, SE O LIMITE DE PERGUNTAS PULADAS NÃO FOR EXCEDIDO.
  Future<void> skipQuestion() async {
    if (skippedQuestions.value < 3) {
      currentQuestionIndex++;
      skippedQuestions++;
    } else {
      if (errors.value + correctAnswers.value == 3) {
        await saveResultsFB();
        Get.offNamed(
          Routes.resultRoundView,
          arguments: {
            'correctAnswers': correctAnswers.value,
            'type': 'challenge',
          },
        );
      } else {
        currentQuestionIndex++;
        questionCounter++;
        skippedQuestions.value = 0;
      }
    }
  }

  /// AVANÇA PARA A PRÓXIMA PERGUNTA.
  Future<void> nextQuestion() async {
    if (correctAnswers.value + errors.value == 15) {
      await saveResultsFB();
      Get.offNamed(
        Routes.resultRoundView,
        arguments: {
          'correctAnswers': correctAnswers.value,
          'type': 'challenge',
        },
      );
    } else {
      questionCounter++;
    }
  }

  /// SALVA OS RESULTADOS NO FIREBASE
  Future<void> saveResultsFB() async {
    // para o cronometro
    stopwatch.stop();

    // calcula o tempo total
    int totalTime = stopwatch.elapsed.inSeconds;

    List<Map> currentUser = await UserDB().getUserDataDB();
    String name = currentUser[0]['email'];

    // salva os resultados no firebase
    await firebaseService.saveResult(correctAnswers.value, totalTime, name);

    // navega para a tela de resultados
    Get.offNamed(
      Routes.resultRoundView,
      arguments: correctAnswers.value,
    );
  }

  bool isCorrectAnswer(int answerIndex) {
    bool isCorrect =
        selectedQuestions[currentQuestionIndex.value].correctAnswerIndex ==
            answerIndex;

    if (isCorrect) {
      correctAnswers++;
    } else {
      errors++;
    }

    return isCorrect;
  }

  bool isFinished(int answerIndex) {
    isCorrectAnswer(answerIndex);

    if (errors.value + correctAnswers.value == 15) {
      return true;
    } else {
      nextQuestion();
      currentQuestionIndex++;
      return false;
    }
  }
}
