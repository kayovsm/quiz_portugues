import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/routes.dart';
import 'common/alert/alert_center_common.dart';
import 'common/assets/app/app_icon_common.dart';
import 'common/assets/asset_icon_common.dart';
import 'common/button/button_common.dart';
import 'common/color/color_common.dart';
import 'common/text/text_common.dart';

class TopInfoSection extends StatelessWidget {
  final double screenW;
  final dynamic controller;
  final Widget timerWidget;
  final String questionCounter;
  final String type;

  const TopInfoSection({
    super.key,
    required this.screenW,
    required this.controller,
    required this.timerWidget,
    required this.questionCounter,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    try {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: screenW,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorCommon.black,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonCommon().icon(
              icon: AppIconCommon.arrowBack,
              color: ColorCommon.white,
              margin: 10,
              onTap: () async {
                // Pausar o cronômetro
                if (type == 'learn') {
                  controller.animationController.stop();
                } else {
                  controller.stopwatch.stop();
                }
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
                  // continuar o cronometro
                  if (type == 'learn') {
                    controller.animationController.forward();
                  } else {
                    controller.stopwatch.start();
                  }
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
      debugPrint('Error in TopInfoSection: $e\n$stackTrace');
      return const Text('Error loading TopInfoSection');
    }
  }
}
