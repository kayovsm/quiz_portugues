import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/routes.dart';
import 'alert_explanation_widget.dart';
import 'common/assets/app/app_icon_common.dart';
import 'common/button/button_common.dart';
import 'common/color/color_common.dart';

class AnswerSectionWidget extends StatelessWidget {
  final double screenH;
  final dynamic controller;
  final String type;

  const AnswerSectionWidget({
    super.key,
    required this.screenH,
    required this.controller,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    try {
      return Expanded(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: ColorCommon.white,
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 225, 223, 223),
                blurRadius: 5,
                offset: Offset(0, -6),
              ),
            ],
          ),
          height: screenH,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(top: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(() {
                    return ButtonCommon().textIcon(
                      icon: AppIconCommon.next,
                      label: ' ${controller.skippedQuestions}/3',
                      fullWidth: false,
                      onTap: controller.skippedQuestions.value == 3
                          ? () {}
                          : controller.skipQuestion,
                      buttonColor: controller.skippedQuestions.value == 3
                          ? ColorCommon.grey
                          : ColorCommon.orange,
                    );
                  }),
                ],
              ),
              Obx(() {
                final options = controller
                    .selectedQuestions[controller.currentQuestionIndex.value]
                    .options;
                return Column(
                  children: options.map<Widget>((option) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: ButtonCommon().text(
                        label: option,
                        borderRadius: 16,
                        padding: 16,
                        onTap: () => _buildShowExplanation(1),
                      ),
                    );
                  }).toList(),
                );
              }),
            ],
          ),
        ),
      );
    } catch (e, stackTrace) {
      debugPrint('Error in _buildAnswerSection: $e\n$stackTrace');
      return const Text('Error loading AnswerSection');
    }
  }

  Future<Object> _buildShowExplanation(int answerIndex) async {
    try {
      bool isCorrectAnswer = controller
              .selectedQuestions[controller.currentQuestionIndex.value]
              .correctAnswerIndex ==
          answerIndex;

      // Pausar o cronômetro
      if (type == 'learn') {
        controller.animationController.stop();
      } else {
        controller.stopwatch.stop();
        ();
      }

      return Get.bottomSheet(
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
            ),
            child: AlertExplanationWidget(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30)),
              title: isCorrectAnswer
                  ? "Parabéns, você acertou!"
                  : "Ops, você errou!",
              explanationText:
                  'Resposta Correta: ${controller.selectedQuestions[controller.currentQuestionIndex.value].correctAnswerText}.\n\nExplicação: ${controller.selectedQuestions[controller.currentQuestionIndex.value].explanation}',
              answerNumber: answerIndex,
              image: isCorrectAnswer ? 'target1' : 'target2',
              buttonText: "Ok",
              onTap: () {
                bool isFinished = controller.isFinished(answerIndex);

                if (isFinished) {
                  // navega para a tela de resultados
                  Get.offNamed(
                    Routes.resultRoundView,
                    arguments: {
                      'correctAnswers': controller.correctAnswers.value,
                      'type': type,
                    },
                  );
                } else {
                  // continua o cronometro
                  if (type == 'learn') {
                    controller.animationController.forward();
                  } else {
                    controller.stopwatch.start();
                  }
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
    } catch (e, stackTrace) {
      debugPrint('Error in _buildShowExplanation: $e\n$stackTrace');
      return const Text('Error loading ShowExplanation');
    }
  }
}
