import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_portugues/app/ui/widgets/common/alert/alert_center_common.dart';
import 'package:quiz_portugues/app/ui/widgets/common/utils/util_screen_common.dart';
import '../../routes/routes.dart';
import '../widgets/common/assets/app/app_icon_common.dart';
import '../widgets/common/assets/asset_icon_common.dart';
import '../widgets/common/button/button_common.dart';
import '../widgets/common/color/color_common.dart';
import '../widgets/common/text/text_common.dart';
import '../widgets/question_widget.dart';

class QuestionsView extends StatelessWidget {
  final String questionCounter;
  final Widget timerWidget;
  final dynamic controller;

  QuestionsView({super.key})
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
              _buildTopInfoSection(screenW, context),
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
                          _buildQuestionSection(constraints),
                          _buildAnswerSection(screenH),
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

  Widget _buildTopInfoSection(double screenW, BuildContext context) {
    try {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: screenW,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorCommon.black,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonCommon().icon(
              icon: AppIconCommon.arrowBack,
              color: ColorCommon.white,
              onTap: () async {
                controller.animationController.stop();
                var result = await AlertCenterCommon().confirm(
                  context: context,
                  title: 'Sair do Desafio',
                  description: 'Deseja realmente sair do desafio?',
                  leftButtonLabel: 'Não',
                  rightButtonLabel: 'Sim',
                  leftButtonColor: ColorCommon.blue,
                  rightButtonColor: ColorCommon.red,
                );

                if (result != null && result[0] == 2) {
                  Get.offAllNamed(Routes.homeView);
                } else {
                  controller.animationController.forward();
                }
              },
            ),
            Obx(() {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                decoration: BoxDecoration(
                  color: ColorCommon.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AssetIconCommon(
                      icon: AppIconCommon.list,
                      color: ColorCommon.black,
                    ),
                    const SizedBox(width: 5),
                    TextCommon.subtitle(
                        text:
                            '${controller.questionCounter.value}/$questionCounter'),
                  ],
                ),
              );
            }),
            timerWidget,
            const SizedBox(width: 8),
          ],
        ),
      );
    } catch (e, stackTrace) {
      debugPrint('Error in _buildTopInfoSection: $e\n$stackTrace');
      return const Text('Error loading TopInfoSection');
    }
  }

  Widget _buildQuestionSection(BoxConstraints constraints) {
    try {
      return Padding(
        padding: const EdgeInsets.all(14),
        child: Obx(() {
          final question = controller
              .selectedQuestions[controller.currentQuestionIndex.value]
              .question;
          return QuestionWidget(
            height: constraints.maxHeight * 0.24,
            text: question,
          );
        }),
      );
    } catch (e, stackTrace) {
      debugPrint('Error in _buildQuestionSection: $e\n$stackTrace');
      return const Text('Error loading QuestionSection');
    }
  }

  Widget _buildAnswerSection(double screenH) {
    try {
      return Expanded(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: ColorCommon.white,
          ),
          height: screenH,
          padding: const EdgeInsets.all(16),
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
                          ? null
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
                        onTap: () => controller.showExplanation(1),
                        label: option,
                        borderRadius: 16,
                        padding: 16,
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
}
