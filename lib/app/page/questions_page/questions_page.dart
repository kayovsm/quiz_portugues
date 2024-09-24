import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../style/font_size.dart';
import '../../style/my_colors.dart';
import '../../style/svg_asset.dart';
import '../../widgets/botaoAlternativas.dart';
import '../../widgets/botaoIrformacoesTopo.dart';
import '../../widgets/cronometro.dart';
import '../../widgets/perguntasWidget.dart';
import 'questions_page_controller.dart';

class QuestionsPage extends StatelessWidget {
  const QuestionsPage({super.key});
  // static const routeName = '/questionsPage';

  @override
  Widget build(BuildContext context) {
    final QuestionsController controller = Get.put(QuestionsController());

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          color: MyColors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Obx(() => TopInfoButton(
                          buttonTxt: '${controller.questionCounter}/10',
                          icon: "lista",
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
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 12,
                            ),
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
                              height: screenHeight,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Obx(() => ElevatedButton(
                                            onPressed: controller
                                                        .skippedQuestions
                                                        .value ==
                                                    3
                                                ? null
                                                : controller.skipQuestion,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: MyColors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                SvgAsset(
                                                  icon: 'avancar',
                                                  color: controller
                                                              .skippedQuestions
                                                              .value ==
                                                          3
                                                      ? MyColors.black
                                                      : MyColors.white,
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  'Skip',
                                                  style: TextStyle(
                                                    fontSize:
                                                        FontSize.getFontSize(
                                                            context),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  ' ${controller.skippedQuestions}/3',
                                                  style: TextStyle(
                                                    fontSize:
                                                        FontSize.getFontSize(
                                                            context),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
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
