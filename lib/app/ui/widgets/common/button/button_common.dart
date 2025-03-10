import 'package:flutter/material.dart';

import '../assets/asset_icon_common.dart';
import '../color/color_common.dart';
import '../utils/util_screen_common.dart';
import '../utils/util_preference_common.dart';

class ButtonCommon {
  // BOTAO COM ICONE
  Widget icon({
    required String icon,
    required VoidCallback onTap,
    Color color = ColorCommon.black,
    double? iconH,
    double borderRadius = 16,
    double margin = 0,
    Color background = ColorCommon.transparent,
    Color? borderColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(margin),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(borderRadius),
          border: borderColor != null
              ? Border.all(
                  color: borderColor,
                  width: 1,
                )
              : null,
        ),
        child: AssetIconCommon(
          icon: icon,
          color: color,
          iconHeight: iconH,
        ),
      ),
    );
  }

  // BOTAO COM TEXTO
  Widget text({
    required String label,
    required VoidCallback onTap,
    Color buttonColor = ColorCommon.black,
    Color labelColor = ColorCommon.white,
    double borderRadius = 20,
    double padding = 12,
    bool oneLine = true,
    bool fullWidth = true,
    Color? borderColor,
  }) {
    final userPrefsController = UtilPreferenceCommon();

    return GestureDetector(
      onTap: onTap,
      child: IntrinsicWidth(
        child: Container(
          width: fullWidth ? UtilScreenCommon.screenWidth : null,
          padding: EdgeInsets.symmetric(vertical: padding),
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: borderColor != null
                ? Border.all(
                    color: borderColor,
                    width: 1,
                  )
                : null,
          ),
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: oneLine ? 1 : 2,
              style: TextStyle(
                fontFamily: 'Ubuntu',
                color: labelColor,
                fontWeight: FontWeight.w700,
                fontSize: _getFontSize(userPrefsController.fontSizeOption),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // BOTAO COM ICONE E TEXTO
  Widget textIcon({
    required String label,
    required VoidCallback onTap,
    required String icon,
    Color buttonColor = ColorCommon.black,
    Color labelColor = ColorCommon.white,
    Color iconColor = ColorCommon.white,
    double? iconHeight,
    double borderRadius = 20,
    bool oneLine = true,
    bool fullWidth = true,
    Color? borderColor,
  }) {
    final userPrefsController = UtilPreferenceCommon();

    return GestureDetector(
      onTap: onTap,
      child: IntrinsicWidth(
        child: Container(
          width: fullWidth ? UtilScreenCommon.screenWidth : null,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: borderColor != null
                ? Border.all(
                    color: borderColor,
                    width: 1,
                  )
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 16),
              AssetIconCommon(
                icon: icon,
                color: iconColor,
                iconHeight: iconHeight,
              ),
              Center(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: oneLine ? 1 : 2,
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    color: labelColor,
                    fontWeight: FontWeight.w700,
                    fontSize: _getFontSize(userPrefsController.fontSizeOption),
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }

  double? _getFontSize(FontSizeOption option) {
    final fontSizeMap = {
      FontSizeOption.small: 15.0,
      FontSizeOption.medium: 16.0,
      FontSizeOption.large: 17.0,
    };

    return fontSizeMap[option] ?? 16.0;
  }
}
