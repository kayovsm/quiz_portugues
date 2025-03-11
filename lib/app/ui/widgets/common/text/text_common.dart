import 'package:flutter/material.dart';
import 'package:quiz_portugues/app/ui/widgets/common/utils/util_screen_common.dart';
import '../utils/util_preference_common.dart';

class TextCommon {
  /// cria um widget de texto estilizado como título
  static Widget title({
    required String text, // texto a ser exibido
    Color? color, // cor do texto
    TextAlign textAlign = TextAlign.start, // alinhamento do texto
    double? fontSize, // tamanho da fonte
    bool oneLine = false, // se deve exibir apenas uma linha
  }) {
    final userPrefsController = UtilPreferenceCommon();
    final BuildContext context = UtilScreenCommon.contextUtil;

    double finalFontSize;

    if (fontSize != null) {
      finalFontSize = fontSize; // usa o tamanho da fonte fornecido
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

  /// cria um widget de texto estilizado como subtítulo
  static Widget subtitle({
    required String text, // texto a ser exibido
    Color? color, // cor do texto
    TextAlign textAlign = TextAlign.start, // alinhamento do texto
    double? fontSize, // tamanho da fonte
    bool oneLine = false, // se deve exibir apenas uma linha
  }) {
    final userPrefsController = UtilPreferenceCommon();
    final BuildContext context = UtilScreenCommon.contextUtil;

    double finalFontSize;

    if (fontSize != null) {
      finalFontSize = fontSize; // usa o tamanho da fonte fornecido
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

  /// cria um widget de texto estilizado como descrição
  static Widget description({
    required String text, // texto a ser exibido
    Color? color, // cor do texto
    TextAlign textAlign = TextAlign.start, // alinhamento do texto
    bool oneLine = false, // se deve exibir apenas uma linha
    double? fontSize, // tamanho da fonte
  }) {
    final userPrefsController = UtilPreferenceCommon();
    final BuildContext context = UtilScreenCommon.contextUtil;

    double finalFontSize;

    if (fontSize != null) {
      finalFontSize = fontSize; // usa o tamanho da fonte fornecido
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
