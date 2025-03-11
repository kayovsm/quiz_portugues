import 'package:flutter/widgets.dart';

/// enumeração para identificar o tipo de dispositivo
enum Device { mobile, tablet, desktop }

/// classe UtilScreenCommon para gerenciar informações da tela e contexto do aplicativo
class UtilScreenCommon {
  static late double screenWidth;
  static late double screenHeight;
  static late BuildContext contextUtil;

  /// inicializa os valores de largura e altura da tela, e armazena o contexto do aplicativo
  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenWidth = size.width; // armazena a largura da tela
    screenHeight = size.height; // armazena a altura da tela
    contextUtil = context; // armazena o contexto do aplicativo
  }

  /// obtém o tipo de dispositivo com base na largura da tela
  /// retorna Device.mobile, Device.tablet ou Device.desktop
  static Device getDeviceType() {
    if (screenWidth < 600) {
      return Device.mobile; // retorna mobile se a largura for menor que 600
    } else if (screenWidth >= 600 && screenWidth < 1200) {
      return Device.tablet; // retorna tablet se a largura for entre 600 e 1199
    } else {
      return Device
          .desktop; // retorna desktop se a largura for maior ou igual a 1200
    }
  }

  /// obtém o tamanho do ícone com base no tipo de dispositivo
  /// retorna um valor de double correspondente ao tamanho do ícone
  static double getIconSize() {
    Device deviceType = getDeviceType();
    double iconH;

    switch (deviceType) {
      case Device.mobile:
        iconH = 30; // define tamanho do ícone para mobile
        break;
      case Device.tablet:
        iconH = 36; // define tamanho do ícone para tablet
        break;
      case Device.desktop:
        iconH = 38; // define tamanho do ícone para desktop
        break;
    }
    return iconH;
  }

  /// obtém o tamanho da fonte com base no tipo de dispositivo
  /// retorna um valor de double correspondente ao tamanho da fonte
  static double getFontSize() {
    Device deviceType = getDeviceType();
    double fontSize;
    switch (deviceType) {
      case Device.mobile:
        fontSize = 16; // define tamanho da fonte para mobile
        break;
      case Device.tablet:
        fontSize = 18; // define tamanho da fonte para tablet
        break;
      case Device.desktop:
        fontSize = 18; // define tamanho da fonte para desktop
        break;
    }
    return fontSize;
  }

  /// obtém a margem interna do corpo da tela com base no tipo de dispositivo
  /// retorna um valor de double correspondente à margem interna
  static double getPaddingBody() {
    Device deviceType = getDeviceType();
    double paddingH;

    switch (deviceType) {
      case Device.mobile:
        paddingH = 18; // define margem interna para mobile
        break;
      case Device.tablet:
        paddingH = 50; // define margem interna para tablet
        break;
      case Device.desktop:
        paddingH = 80; // define margem interna para desktop
        break;
    }
    return paddingH;
  }

  /// obtém a margem interna da barra de aplicativos com base no tipo de dispositivo
  /// retorna um valor de double correspondente à margem interna
  static double getPaddingAppBar() {
    Device deviceType = getDeviceType();
    double paddingH;

    switch (deviceType) {
      case Device.mobile:
        paddingH = 0; // define margem interna para mobile
        break;
      case Device.tablet:
        paddingH = 25; // define margem interna para tablet
        break;
      case Device.desktop:
        paddingH = 25; // define margem interna para desktop
        break;
    }
    return paddingH;
  }

  /// obtém a largura do diálogo com base no tipo de dispositivo
  /// retorna um valor de double correspondente à largura do diálogo
  static double getDialogWidth() {
    Device deviceType = getDeviceType();
    double dialogWidth;

    switch (deviceType) {
      case Device.mobile:
        dialogWidth = screenWidth - 40; // define largura do diálogo para mobile
        break;
      case Device.tablet:
        dialogWidth =
            screenWidth - 150; // define largura do diálogo para tablet
        break;
      case Device.desktop:
        dialogWidth = 400; // define largura do diálogo para desktop
        break;
    }
    return dialogWidth;
  }
}
