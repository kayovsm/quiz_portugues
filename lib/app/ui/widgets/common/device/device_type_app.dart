import 'package:flutter/widgets.dart';

enum Device { mobile, tablet, desktop }

class DeviceTypeApp {
  static late double screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
  }

  static Device getDeviceType() {
    if (screenWidth < 600) {
      return Device.mobile;
    } else if (screenWidth >= 600 && screenWidth < 1200) {
      return Device.tablet;
    } else {
      return Device.desktop;
    }
  }

  static double getIconSize() {
    Device deviceType = getDeviceType();
    double iconH;

    switch (deviceType) {
      case Device.mobile:
        iconH = 30;
        break;
      case Device.tablet:
        iconH = 36;
        break;
      case Device.desktop:
        iconH = 38;
        break;
    }
    return iconH;
  }

  static double getFontSize() {
    Device deviceType = getDeviceType();
    double fontSize;
    switch (deviceType) {
      case Device.mobile:
        fontSize = 16;
        break;
      case Device.tablet:
        fontSize = 18;
        break;
      case Device.desktop:
        fontSize = 18;
        break;
    }
    return fontSize;
  }

  static double getPaddingBody() {
    Device deviceType = getDeviceType();
    double paddingH;

    switch (deviceType) {
      case Device.mobile:
        paddingH = 18;
        break;
      case Device.tablet:
        paddingH = 50;
        break;
      case Device.desktop:
        paddingH = 80;
        break;
    }
    return paddingH;
  }

  static double getPaddingAppBar() {
    Device deviceType = getDeviceType();
    double paddingH;

    switch (deviceType) {
      case Device.mobile:
        paddingH = 0;
        break;
      case Device.tablet:
        paddingH = 25;
        break;
      case Device.desktop:
        paddingH = 25;
        break;
    }
    return paddingH;
  }

  static double getDialogWidth() {
    Device deviceType = getDeviceType();
    double dialogWidth;

    switch (deviceType) {
      case Device.mobile:
        dialogWidth = screenWidth - 40;
        break;
      case Device.tablet:
        dialogWidth = screenWidth - 150;
        break;
      case Device.desktop:
        dialogWidth = 400;
        break;
    }
    return dialogWidth;
  }
}
