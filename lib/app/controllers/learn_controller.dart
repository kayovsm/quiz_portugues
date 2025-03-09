import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/database/questions_db.dart';
import '../data/models/question_model.dart';
import '../routes/routes.dart';
import '../ui/widgets/alert_explanation_widget.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

// CONTROLADOR PARA GERENCIAR O ESTADO E A LÓGICA DO QUIZ DE PERGUNTAS.
class LearnController extends GetxController with GetTickerProviderStateMixin {
  final QuestionsDB dbHelper = QuestionsDB();
  late Future<List<QuestionModel>> questionsFuture;

  var currentQuestionIndex = 0.obs; // índice da pergunta atual
  var questionCounter = 1.obs; // contador de perguntas
  var errors = 0.obs; // contador de erros
  var correctAnswers = 0.obs; // contador de respostas corretas
  var skippedQuestions = 0.obs; // contador de perguntas puladas
  var selectedAnswer = (-1).obs; // índice da resposta selecionada
  late AnimationController
      animationController; // controlador de animação para o timer
  var selectedQuestions =
      <QuestionModel>[].obs; // lista de perguntas selecionadas
  late Stopwatch stopwatch; // plugin do cronometro

  @override
  void onInit() async {
    super.onInit();
    initializeController();
    loadQuestions();

    // inicializa o Stopwatch
    stopwatch = Stopwatch();
  }

  /// INICIALIZA O CONTROLADOR DE ANIMAÇÃO E CONFIGURA O LISTENER PARA O TIMER.
  Future<void> initializeController() async {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 30));
    animationController.addListener(() {
      if (animationController.isCompleted) {
        onTimeUp();
      }
    });
    animationController.forward(); // inicia o timer
  }

  /// CARREGA AS PERGUNTAS DO BANCO DE DADOS E SELECIONA AS PERGUNTAS PARA A RODADA.
  Future<void> loadQuestions() async {
    dbHelper.initializeDatabase().then((_) {
      questionsFuture = dbHelper.getQuestions();
    });

    // // seleciona perguntas para a rodada
    // quizDados.shuffle();
    // selectedQuestions.value =
    //     quizDados.take(13).toList(); // seleciona 13 perguntas do banco de dados

    // for (var question in selectedQuestions) {
    //   int correctAnswerIndex = question.correctAnswerIndex;
    //   List<String> options = question.options.cast<String>();
    //   String correctAnswer = options[correctAnswerIndex - 1];
    //   options.shuffle(); // embaralha as opções
    //   int newCorrectAnswerIndex = options.indexOf(correctAnswer) + 1;
    //   question.correctAnswerIndex = newCorrectAnswerIndex;
    //   question.options = options;
    // }

    // Carrega perguntas do arquivo JSON
    loadQuestionsFromJson().then((questions) {
      selectedQuestions.value = questions.take(13).toList();

      for (var question in selectedQuestions) {
        int correctAnswerIndex = question.correctAnswerIndex;
        List<String> options = question.options.cast<String>();
        String correctAnswer = options[correctAnswerIndex - 1];
        options.shuffle(); // embaralha as opções
        int newCorrectAnswerIndex = options.indexOf(correctAnswer) + 1;
        question.correctAnswerIndex = newCorrectAnswerIndex;
        question.options = options;
      }

      // Timer.periodic(const Duration(seconds: 1), (timer) {
      //   elapsedTime.value = stopwatch.elapsed;
      // });
    });
  }

  @override
  void onClose() {
    if (animationController.isAnimating || animationController.isCompleted) {
      animationController.dispose();
    }
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

  /// REINICIA O QUIZ, RESETANDO TODOS OS CONTADORES E REINICIANDO O TIMER.
  Future<void> resetQuiz() async {
    currentQuestionIndex.value = 0;
    questionCounter.value = 1;
    errors.value = 0;
    correctAnswers.value = 0;
    skippedQuestions.value = 0;
    selectedAnswer.value = -1;
    await initializeController();
    await loadQuestions();
  }

  /// PULA A PERGUNTA ATUAL, SE O LIMITE DE PERGUNTAS PULADAS NÃO FOR EXCEDIDO.
  void skipQuestion() {
    if (skippedQuestions.value < 3) {
      currentQuestionIndex++;
      skippedQuestions++;
      animationController.reset();
      animationController.forward();
    } else {
      if (errors.value + correctAnswers.value == 10) {
        Get.offNamed(
          Routes.resultRoundView,
          arguments: {
            'correctAnswers': correctAnswers.value,
            'type': 'learn',
          },
        );
        Get.delete<LearnController>();
      } else {
        currentQuestionIndex++;
        questionCounter++;
        skippedQuestions.value = 0;
        animationController.reset();
        animationController.forward();
      }
    }
  }

  /// EXIBE UMA MENSAGEM QUANDO O TEMPO DA PERGUNTA SE ESGOTA.
  void onTimeUp() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
          ),
          child: AlertExplanationWidget(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            title: "Tempo esgotado!",
            explanationText:
                "\nVocê acertou: ${correctAnswers.value} de ${correctAnswers.value + errors.value}\n",
            image: 'coming_soon',
            buttonText: "Reiniciar",
            onTap: () async {
              await resetQuiz();
              Get.back(); // fecha o bottom sheet
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

  /// AVANÇA PARA A PRÓXIMA PERGUNTA.
  void nextQuestion() {
    if (correctAnswers.value + errors.value == 10) {
      if (animationController.isAnimating || animationController.isCompleted) {
        animationController.stop();
      }
      Get.offNamed(
        Routes.resultRoundView,
        arguments: correctAnswers.value,
      );
      Get.delete<LearnController>();
    } else {
      questionCounter++;
      animationController.reset(); // reseta o timer
      animationController.forward(); // inicia o timer
    }
  }

  /// EXIBE A EXPLICAÇÃO DA RESPOSTA SELECIONADA.
  void showExplanation(int answerIndex) async {
    if (animationController.isAnimating || animationController.isCompleted) {
      animationController.stop();
    }
    bool isCorrectAnswer =
        selectedQuestions[currentQuestionIndex.value].correctAnswerIndex ==
            answerIndex;
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
              if (errors.value + correctAnswers.value == 10) {
                Get.offNamed(
                  Routes.resultRoundView,
                  arguments: {
                    'correctAnswers': correctAnswers.value,
                    'type': 'learn',
                  },
                );
                Get.delete<LearnController>();
              } else {
                nextQuestion();
                currentQuestionIndex++;
                animationController.reset(); // reseta o timer
                animationController.forward(); // inicia o timer
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
}
