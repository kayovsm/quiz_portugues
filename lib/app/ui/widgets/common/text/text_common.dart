import 'package:flutter/material.dart';
import 'package:quiz_portugues/app/ui/widgets/common/utils/util_screen_common.dart';
import '../utils/util_preference_common.dart';

class TextCommon {
  static Widget title({
    required String text,
    Color? color,
    TextAlign textAlign = TextAlign.start,
    double? fontSize,
    bool oneLine = false,
  }) {
    final userPrefsController = UtilPreferenceCommon();
    final BuildContext context = UtilScreenCommon.contextUtil;

    double finalFontSize;

    if (fontSize != null) {
      finalFontSize = fontSize;
    } else {
      switch (userPrefsController.fontSizeOption) {
        case FontSizeOption.small:
          finalFontSize = 16;
          break;
        case FontSizeOption.medium:
          finalFontSize = 17.5;
          break;
        case FontSizeOption.large:
          finalFontSize = 19;
          break;
      }
    }

    return Text(
      text,
      textAlign: textAlign,
      maxLines: oneLine ? 1 : null,
      overflow: oneLine ? TextOverflow.ellipsis : TextOverflow.visible,
      softWrap: oneLine ? false : true,
      style: TextStyle(
        fontFamily: 'Open Sans',
        color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
        fontWeight: FontWeight.w700,
        fontSize: finalFontSize,
      ),
    );
  }

  static Widget subtitle({
    required String text,
    Color? color,
    TextAlign textAlign = TextAlign.start,
    double? fontSize,
    bool oneLine = false,
  }) {
    final userPrefsController = UtilPreferenceCommon();
    final BuildContext context = UtilScreenCommon.contextUtil;

    double finalFontSize;

    if (fontSize != null) {
      finalFontSize = fontSize;
    } else {
      switch (userPrefsController.fontSizeOption) {
        case FontSizeOption.small:
          finalFontSize = 15;
          break;
        case FontSizeOption.medium:
          finalFontSize = 16.5;
          break;
        case FontSizeOption.large:
          finalFontSize = 18;
          break;
      }
    }

    return Text(
      text,
      textAlign: textAlign,
      maxLines: oneLine ? 1 : null,
      overflow: oneLine ? TextOverflow.ellipsis : TextOverflow.visible,
      softWrap: oneLine ? false : true,
      style: TextStyle(
        fontFamily: 'Raleway',
        color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
        fontWeight: FontWeight.w500,
        fontSize: finalFontSize,
        decoration: TextDecoration.none,
      ),
    );
  }

  static Widget description({
    required String text,
    Color? color,
    TextAlign textAlign = TextAlign.start,
    bool oneLine = false,
    double? fontSize,
  }) {
    final userPrefsController = UtilPreferenceCommon();
    final BuildContext context = UtilScreenCommon.contextUtil;

    double finalFontSize;

    if (fontSize != null) {
      finalFontSize = fontSize;
    } else {
      switch (userPrefsController.fontSizeOption) {
        case FontSizeOption.small:
          finalFontSize = 14;
          break;
        case FontSizeOption.medium:
          finalFontSize = 15.5;
          break;
        case FontSizeOption.large:
          finalFontSize = 17;
          break;
      }
    }

    return Text(
      text,
      textAlign: textAlign,
      maxLines: oneLine ? 1 : null,
      overflow: oneLine ? TextOverflow.ellipsis : TextOverflow.visible,
      softWrap: oneLine ? false : true,
      style: TextStyle(
        fontFamily: 'Raleway',
        color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
        fontWeight: FontWeight.w400,
        fontSize: oneLine ? finalFontSize - 1 : finalFontSize,
      ),
    );
  }
}
