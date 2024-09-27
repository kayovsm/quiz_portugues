import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_portugues/app/widgets/button_txt.dart';
import '../../style/my_colors.dart';
import '../../widgets/botaoAlternativas.dart';
import '../../widgets/botaoIrformacoesTopo.dart';
import '../../widgets/cronometro.dart';
import '../../widgets/perguntasWidget.dart';
import 'questions_page_controller.dart';

class QuestionsPage extends StatelessWidget {
  const QuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final QuestionsController controller = Get.put(QuestionsController());

    final screenH = MediaQuery.of(context).size.height;
    final screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: screenW,
          height: screenH,
          color: MyColors.white,
          child: Column(
            children: <Widget>[
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: screenW,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: MyColors.black,
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Obx(() => TopInfoButton(
                          buttonTxt: '${controller.questionCounter}/10',
                          icon: "list",
                        )),
                    TimerWidget(
                      animation: StepTween(begin: 31, end: 0)
                          .animate(controller.controller),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (_, constraints) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: MyColors.white,
                      ),
                      height: constraints.maxHeight * .9,
                      width: constraints.maxWidth,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(14),
                            child: Obx(() => QuestionWidget(
                                  height: constraints.maxHeight * 0.24,
                                  txt: controller
                                      .selectedQuestions[
                                          controller.currentQuestionIndex.value]
                                      .question,
                                )),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: MyColors.white,
                              ),
                              height: screenH,
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Obx(() => ButtonTxt(
                                            iconBtn: 'next',
                                            txtBtn:
                                                ' ${controller.skippedQuestions}/3',
                                            fullWidth: false,
                                            txtColor: MyColors.black,
                                            iconColor: MyColors.black,
                                            onTap: controller.skippedQuestions
                                                        .value ==
                                                    3
                                                ? null
                                                : controller.skipQuestion,
                                            btnColor: controller
                                                        .skippedQuestions
                                                        .value ==
                                                    3
                                                ? MyColors.cutGrey
                                                : MyColors.yellow,
                                          )),
                                    ],
                                  ),
                                  Obx(() => Column(
                                        children: controller
                                            .selectedQuestions[controller
                                                .currentQuestionIndex.value]
                                            .options
                                            .map((option) {
                                          return AnswerButton(
                                            onTap: () =>
                                                controller.showExplanation(1),
                                            txtBtn: option,
                                          );
                                        }).toList(),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
