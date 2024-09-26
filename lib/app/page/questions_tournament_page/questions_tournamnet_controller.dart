import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_portugues/app/models/database/user_data.dart';
import '../../models/dataBaseHelper.dart';
import '../../models/questions.dart';
import '../../models/quiz_dados.dart';
import '../../routes/routes_mobile.dart';
import '../../widgets/alertaExplicacao.dart';

class QuestionsTournamentController extends GetxController {
  final DatabaseHelper dbHelper = DatabaseHelper();
  late Future<List<Question>> questionsFuture;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var currentQuestionIndex = 0.obs;
  var questionCounter = 1.obs;
  var errors = 0.obs;
  var correctAnswers = 0.obs;
  var skippedQuestions = 0.obs;
  var selectedAnswer = (-1).obs;
  var selectedQuestions = <Question>[].obs;
  late Stopwatch stopwatch;
  var elapsedTime = Duration().obs;

  @override
  void onInit() {
    super.onInit();
    stopwatch = Stopwatch()..start();
    dbHelper.initializeDatabase().then((_) {
      questionsFuture = dbHelper.getQuestions();
    });

    // Select questions for the round
    quizDados.shuffle();
    selectedQuestions.value = quizDados.take(18).toList();

    for (var question in selectedQuestions) {
      int correctAnswerIndex = question.correctAnswerIndex;
      List<String> options = question.options.cast<String>();
      String correctAnswer = options[correctAnswerIndex - 1];
      options.shuffle(); // Shuffle the options
      int newCorrectAnswerIndex = options.indexOf(correctAnswer) + 1;
      question.correctAnswerIndex = newCorrectAnswerIndex;
      question.options = options;
    }

    Timer.periodic(const Duration(seconds: 1), (timer) {
      elapsedTime.value = stopwatch.elapsed;
    });
  }

  @override
  void onClose() {
    stopwatch.stop();
    super.onClose();
  }

  void skipQuestion() {
    if (skippedQuestions.value < 3) {
      currentQuestionIndex++;
      skippedQuestions++;
    } else {
      if (errors.value + correctAnswers.value == 15) {
        saveResultsFB();
      } else {
        currentQuestionIndex++;
        questionCounter++;
        skippedQuestions.value = 0;
      }
    }
  }

  void nextQuestion() {
    if (correctAnswers.value + errors.value == 3) {
      saveResultsFB();
    } else {
      questionCounter++;
    }
  }

  void showExplanation(int answerIndex) async {
    bool isCorrectAnswer =
        selectedQuestions[currentQuestionIndex.value].correctAnswerIndex == answerIndex;

    // pausar o cronômetro
    stopwatch.stop();

    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          title: Text(isCorrectAnswer
              ? "Parabéns, você acertou!"
              : "Oops, você errou!"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Resposta correta: ${selectedQuestions[currentQuestionIndex.value].correctAnswerText}.\n\nExplicação: ${selectedQuestions[currentQuestionIndex.value].explanation}',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Ok"),
              onPressed: () {
                if (selectedQuestions[currentQuestionIndex.value].correctAnswerIndex == answerIndex) {
                  correctAnswers++;
                } else {
                  errors++;
                }
                if (errors.value + correctAnswers.value == 15) {
                  saveResultsFB();
                } else {
                  nextQuestion();
                  currentQuestionIndex++;
                }

                stopwatch.start();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> saveResultsFB() async {
    stopwatch.stop();
    int totalTime = stopwatch.elapsed.inSeconds;

    // Formatar o tempo em MM:SS
    String formattedTime = formatTime(totalTime);

    List<Map> currentUser = await UserDataDB().getUserDataDB();
    // String email = currentUser[0]['email'];
    String name = currentUser[0]['name'];

    await addTestUsers();

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
      Get.offNamed(RoutesMobile.resultPage, arguments: correctAnswers.value);
    });
  }

  // Função para adicionar 10 usuários de teste
  Future<void> addTestUsers() async {
    final List<Map<String, dynamic>> testUsers = List.generate(10, (index) {
      return {
        'name': 'Test User ${index + 1}',
        'correctAnswers': (index + 1) * 2, // Exemplo de pontuação
        'time': formatTime((index + 1) * 10), // Exemplo de tempo formatado
      };
    });

    for (var user in testUsers) {
      await firestore.collection('ranking').add(user);
    }
  }

  // Função para formatar o tempo em MM:SS
  String formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // Função para converter o tempo formatado de volta para segundos
  int parseTime(String formattedTime) {
    List<String> parts = formattedTime.split(':');
    int minutes = int.parse(parts[0]);
    int seconds = int.parse(parts[1]);
    return minutes * 60 + seconds;
  }
}