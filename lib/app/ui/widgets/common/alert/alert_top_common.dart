import 'package:flutter/material.dart';

import '../assets/app/app_icon_common.dart';
import '../assets/asset_icon_common.dart';
import '../color/color_app.dart';
import '../text/description_text_app.dart';
import '../text/subtitle_text_app.dart';

class AlertTopCommon {
  void showNotificationTop({
    required BuildContext context,
    required String? icon,
    required String title,
    required String description,
    required Color backgroundColor,
    required Color textColor,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;
    ValueNotifier<double> topPosition =
        ValueNotifier<double>(-100); // Inicialmente invisível

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            ValueListenableBuilder<double>(
              valueListenable: topPosition,
              builder: (context, value, child) {
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeOut,
                  top: value,
                  left: 20.0,
                  right: 20.0,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        // spacing: 5,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // spacing: 10,
                            children: [
                              AssetIconCommon(
                                icon: icon!,
                                color: ColorApp.white,
                              ),
                              SubTitleTextApp(
                                color: textColor,
                                text: title,
                              ),
                            ],
                          ),
                          DescriptionTextApp(
                            text: description,
                            color: textColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );

    topPosition.value = -100;
    overlay.insert(overlayEntry);

    // Garante que a animação de entrada seja disparada após o primeiro frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      topPosition.value = 20;
    });

    // Aguarda 3 segundos antes de iniciar a animação de saída
    Future.delayed(const Duration(seconds: 3), () {
      topPosition.value = -100;

      Future.delayed(const Duration(milliseconds: 500), () {
        overlayEntry.remove();
      });
    });
  }

  void success({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    showNotificationTop(
      context: context,
      icon: AppIconCommon.checkCircle,
      title: title,
      description: message,
      backgroundColor: isDarkTheme
          ? ColorApp.alertSuccessLightMode
          : ColorApp.alertSuccessLightMode,
      textColor: isDarkTheme ? ColorApp.white : ColorApp.white,
    );
  }

  void error({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    showNotificationTop(
      context: context,
      icon: AppIconCommon.info,
      title: title,
      description: message,
      backgroundColor: isDarkTheme
          ? ColorApp.alertErrorDarkMode
          : ColorApp.alertErrorLightMode,
      textColor: isDarkTheme ? ColorApp.white : ColorApp.white,
    );
  }
}
