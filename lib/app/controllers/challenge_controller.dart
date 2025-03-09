import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_portugues/app/data/database/user_db.dart';

import '../data/database/questions_db.dart';
import '../data/models/question_model.dart';
import '../routes/routes.dart';
import '../ui/widgets/alert_explanation_widget.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

/// CONTROLADOR PARA GERENCIAR O ESTADO E A LÓGICA DO QUIZ DE TORNEIO.
class ChallengeController extends GetxController {
  final QuestionsDB dbHelper = QuestionsDB();
  late Future<List<QuestionModel>> questionsFuture;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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
            'type': 'tournament',
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
          'type': 'tournament',
        },
      );
    } else {
      questionCounter++;
    }
  }

  /// EXIBE A EXPLICAÇÃO DA RESPOSTA SELECIONADA.
  void showExplanation(int answerIndex) async {
    bool isCorrectAnswer =
        selectedQuestions[currentQuestionIndex.value].correctAnswerIndex ==
            answerIndex;

    // pausar o cronômetro
    stopwatch.stop();

    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
          ),
          child: AlertExplanationWidget(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            title: isCorrectAnswer
                ? "Parabéns, você acertou!"
                : "Ops, você errou!",
            explanationText:
                'Resposta Correta: ${selectedQuestions[currentQuestionIndex.value].correctAnswerText}.\n\nExplicação: ${selectedQuestions[currentQuestionIndex.value].explanation}',
            answerNumber: answerIndex,
            image: isCorrectAnswer ? 'target1' : 'target2',
            buttonText: "Ok",
            onTap: () {
              if (selectedQuestions[currentQuestionIndex.value]
                      .correctAnswerIndex ==
                  answerIndex) {
                correctAnswers++;
              } else {
                errors++;
              }
              if (errors.value + correctAnswers.value == 15) {
                Get.offNamed(
                  Routes.resultRoundView,
                  arguments: {
                    'correctAnswers': correctAnswers.value,
                    'type': 'tournament',
                  },
                );
                Get.delete<ChallengeController>();
              } else {
                nextQuestion();
                currentQuestionIndex++;
                stopwatch.start(); // reinicia o cronômetro
              }
            },
          ),
        ),
      ),
      isScrollControlled: true,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }

  /// SALVA OS RESULTADOS NO FIREBASE.
  Future<void> saveResultsFB() async {
    stopwatch.stop();
    int totalTime = stopwatch.elapsed.inSeconds;

    // formata o tempo em MM:SS
    String formattedTime = formatTime(totalTime);

    List<Map> currentUser = await UserDB().getUserDataDB();
    String name = currentUser[0]['email'];

    User user = FirebaseAuth.instance.currentUser!;
    DocumentReference userDoc = firestore.collection('ranking').doc(user.uid);

    userDoc.get().then((doc) {
      if (doc.exists) {
        int savedCorrectAnswers = doc['correctAnswers'];
        String savedTime = doc['time'];

        if (correctAnswers.value > savedCorrectAnswers ||
            (correctAnswers.value == savedCorrectAnswers &&
                totalTime < parseTime(savedTime))) {
          userDoc.set({
            'correctAnswers': correctAnswers.value,
            'time': formattedTime,
            'name': name,
          });
        }
      } else {
        userDoc.set({
          'correctAnswers': correctAnswers.value,
          'time': formattedTime,
          'name': name,
        });
      }
      Get.offNamed(Routes.resultRoundView, arguments: correctAnswers.value);
    });
  }

  /// FUNÇÃO PARA ADICIONAR 10 USUÁRIOS DE TESTE.
  Future<void> addTestUsers() async {
    final List<Map<String, dynamic>> testUsers = List.generate(10, (index) {
      return {
        'name': 'Test User ${index + 1}',
        'correctAnswers': (index + 1) * 2, // exemplo de pontuação
        'time': formatTime((index + 1) * 10), // exemplo de tempo formatado
      };
    });

    for (var user in testUsers) {
      await firestore.collection('ranking').add(user);
    }
  }

  /// FUNÇÃO PARA FORMATAR O TEMPO EM MM:SS.
  String formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// FUNÇÃO PARA CONVERTER O TEMPO FORMATADO DE VOLTA PARA SEGUNDOS.
  int parseTime(String formattedTime) {
    List<String> parts = formattedTime.split(':');
    int minutes = int.parse(parts[0]);
    int seconds = int.parse(parts[1]);
    return minutes * 60 + seconds;
  }
}
