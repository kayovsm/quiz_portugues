import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/dataBaseHelper.dart';
import '../../models/questions.dart';
import '../../models/quiz_dados.dart';
import '../../routes/routes_mobile.dart';
import '../../widgets/alertaExplicacao.dart';

class QuestionsController extends GetxController
    with SingleGetTickerProviderMixin {
  final DatabaseHelper dbHelper = DatabaseHelper();
  late Future<List<Question>> questionsFuture;

  var currentQuestionIndex = 0.obs;
  var questionCounter = 1.obs;
  var errors = 0.obs;
  var correctAnswers = 0.obs;
  var skippedQuestions = 0.obs;
  var selectedAnswer = (-1).obs;
  late AnimationController controller;
  var selectedQuestions = <Question>[].obs;

  @override
  void onInit() {
    super.onInit();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 30));
    controller.addListener(() {
      if (controller.isCompleted) {
        onTimeUp();
      }
    });
    controller.forward(); // Start the timer
    dbHelper.initializeDatabase().then((_) {
      questionsFuture =
          dbHelper.getQuestions(); // Load questions from the database
    });

    // Select questions for the round
    quizDados.shuffle();
    selectedQuestions.value =
        quizDados.take(13).toList(); // Take 13 questions from the database

    for (var question in selectedQuestions) {
      int correctAnswerIndex = question.correctAnswerIndex;
      List<String> options = question.options.cast<String>();
      String correctAnswer = options[correctAnswerIndex - 1];
      options.shuffle(); // Shuffle the options
      int newCorrectAnswerIndex = options.indexOf(correctAnswer) + 1;
      question.correctAnswerIndex = newCorrectAnswerIndex;
      question.options = options;
    }
  }

  @override
  void onClose() {
    if (controller.isAnimating || controller.isCompleted) {
      controller.dispose();
    }
    super.onClose();
  }

  void skipQuestion() {
    if (skippedQuestions.value < 3) {
      currentQuestionIndex++;
      skippedQuestions++;
      controller.reset(); // Reset the timer
    } else {
      if (errors.value + correctAnswers.value == 10) {
        Get.offNamed(RoutesMobile.resultPage,
            arguments:
                correctAnswers.value); // Pass parameter to the result page
      } else {
        currentQuestionIndex++;
        questionCounter++;
        skippedQuestions.value = 0;
        controller.reset(); // Reset the timer
        controller.forward(); // Start the timer
      }
    }
  }

  void onTimeUp() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
          ),
          child: ExplanationAlert(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            title: "Tempo esgotado!",
            explanationText:
                "\nYou got: ${correctAnswers.value} out of ${correctAnswers.value + errors.value}\n",
            image: 'relogio-quebrado',
            buttonText: "Restart",
            onTap: () => Get.offNamed(RoutesMobile.questionsPage),
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

  void nextQuestion() {
    if (correctAnswers.value + errors.value == 10) {
      Get.offNamed(RoutesMobile.resultPage,
          arguments: correctAnswers.value); // Pass parameter to the result page
    } else {
      questionCounter++;
      controller.reset(); // Reset the timer
      controller.forward(); // Start the timer
    }
  }

  void showExplanation(int answerIndex) async {
    controller.stop();
    bool isCorrectAnswer =
        selectedQuestions[currentQuestionIndex.value].correctAnswerIndex ==
            answerIndex;
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
          ),
          child: ExplanationAlert(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            title: isCorrectAnswer
                ? "Congratulations, you got it right!"
                : "Oops, you got it wrong!",
            explanationText:
                'Correct Answer: ${selectedQuestions[currentQuestionIndex.value].correctAnswerText}.\n\nExplanation: ${selectedQuestions[currentQuestionIndex.value].explanation}',
            answerNumber: answerIndex,
            image: isCorrectAnswer ? 'positivo' : 'negativo',
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
                Get.offNamed(RoutesMobile.resultPage,
                    arguments: correctAnswers.value);
              } else {
                nextQuestion();
                currentQuestionIndex++;
                controller.reset(); // Reset the timer
                controller.forward(); // Start the timer
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
