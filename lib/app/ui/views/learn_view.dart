import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/learn_controller.dart';
import '../widgets/answer_section.dart';
import '../widgets/common/color/color_common.dart';
import '../widgets/common/utils/util_screen_common.dart';
import '../widgets/question_widget.dart';
import '../widgets/top_info_section.dart';

class LearnView extends StatelessWidget {
  final String questionCounter;
  final Widget timerWidget;
  final LearnController controller;

  LearnView({super.key})
      : questionCounter = Get.arguments['questionCounter'],
        timerWidget = Get.arguments['timerWidget'],
        controller = Get.arguments['controller'];

  @override
  Widget build(BuildContext context) {
    final screenH = UtilScreenCommon.screenHeight;
    final screenW = UtilScreenCommon.screenWidth;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: screenW,
          height: screenH,
          color: ColorCommon.white,
          child: Column(
            children: <Widget>[
              TopInfoSection(
                screenW: screenW,
                controller: controller,
                timerWidget: timerWidget,
                questionCounter: questionCounter,
                type: 'learn',
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (_, constraints) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: ColorCommon.white,
                      ),
                      height: constraints.maxHeight * .9,
                      width: constraints.maxWidth,
                      child: Column(
                        children: [
                          Obx(() {
                            final question = controller
                                .selectedQuestions[
                                    controller.currentQuestionIndex.value]
                                .question;
                            return QuestionWidget(
                              height: constraints.maxHeight * 0.24,
                              text: question,
                            );
                          }),
                          AnswerSection(
                            screenH: screenH,
                            controller: controller,
                            type: 'learn',
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
