import 'package:flutter/material.dart';

class ColorCommon {
  ColorCommon._privateConstructor();

  static final ColorCommon _instance = ColorCommon._privateConstructor();

  factory ColorCommon() {
    return _instance;
  }

  // STATIC COLORS
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const grey = Color(0xFF616161);
  static const transparent = Colors.transparent;
  static const red = Color(0xFFE9523F);
  static const blue = Color(0xFF313586);

  static const green = Color(0xFF4CAF50);
  static const blueLight = Color(0xFF2196F3);
  static const brown = Color(0xFF795548);
  static const orange = Color(0xFFFF9800);
  static const yellow = Color(0xFFECC721);

  static const finishedLightMode = Color(0xFF313586);
  static const pedingLightMode = Color(0xFFE9523F);
  static const lockLightMode = Color(0xFFA5A5A5);
  static const finishedDarkMode = Color(0xFF005DB2);
  static const pedingDarkMode = Color(0xFFE9523F);
  static const lockDarkMode = Color(0xFF616161);

  static const finished = Color(0xFF005DB2);
  static const peding = Color(0xFFE9523F);
  static const lock = Color(0xFF616161);
 
  // LIGHT MODE
  static const greyLightMode = Color(0xFFB6B4B4);
  // static const backgroundLightMode = Color.fromRGBO(226, 236, 236, 1);
  static const backgroundLightMode = Color(0xFFF2F2F2);

  static const whiteLightMode = Color(0xFFFEFEFE);
  static const blackLightMode = Color(0xFF474747);
  static const blueLightMode = Color(0xFF005DB2);
  static const dialogBackgroundColorLightMode = Color(0xFFEBEBEB);
  static const alertSuccessLightMode = Color(0xFF005DB2);
  static const alertErrorLightMode = Color(0xFFE9523F);
  static const cardLightMode = Color(0xFFEEECEC);
  static const borderCardLightMode = Color(0xFF303136);
  static const appBarLightMode = Color(0xFFFFFFFF);
  static const iconLightMode = Color(0xFF474747);
  static const textTitleLightMode = Color(0xFF000000);
  static const textSubtitleLightMode = Color(0xFF969696);
  static const buttonPrimaryLightMode = Color(0xFF000000);
  static const buttonSecondaryLightMode = Color(0xFFE9523F);
  static const buttonTertiaryLightMode = Colors.transparent;
  static const focusButtonLightMode = Color(0xFF005DB2);
  static const floatingButtonLightMode = Color(0xFF005DB2);
  static const chipLightMode = Color(0xFFEBEBEB);

  // DARK MODE
  static const greyDarkMode = Color(0xFF616161);
  static const backgroundDarkMode = Color(0xFF17181A);
  static const whiteDarkMode = Color(0xFFFEFEFE);
  static const blackDarkMode = Color(0xFF2E2E2E);
  static const dialogBackgroundColorDarkMode = Color(0xFF17181A);
  static const alertSuccessDarkMode = Color(0xFF3D76F1);
  static const alertErrorDarkMode = Color(0xFFE9523F);
  static const cardDarkMode = Color(0xFF303136);
  static const borderCardDarkMode = Color(0xFF8D8D8D);
  static const appBarDarkMode = Color(0xFFB22C00);
  static const iconDarkMode = Color(0xFFFEFEFE);
  static const textTitleDarkMode = Color(0xFFFEFEFE);
  static const textSubtitleDarkMode = Color(0xFF8D8D8D);
  static const buttonPrimaryDarkMode = Color(0xFF005DB2);
  static const buttonSecondaryDarkMode = Color(0xFFE9523F);
  static const buttonTertiaryDarkMode = Colors.transparent;
  static const focusButtonDarkMode = Color(0xFF005DB2);
  static const focusTextDarkMode = Color(0xFFD5D4D4);
  static const floatingButtonDarkMode = Color(0xFF005DB2);
  static const chipDarkMode = Color(0xFF303136);
}

class ThemeApp {
  static ThemeData get lightTheme {
    return _buildThemeData(
      primaryColor: ColorCommon.buttonPrimaryLightMode,
      backgroundColor: ColorCommon.backgroundLightMode,
      textTitleColor: ColorCommon.textTitleLightMode,
      textSubtitleColor: ColorCommon.textSubtitleLightMode,
      appBarColor: ColorCommon.appBarLightMode,
      iconColor: ColorCommon.iconLightMode,
      dialogBackgroundColor: ColorCommon.dialogBackgroundColorLightMode,
      cardColor: ColorCommon.cardLightMode,
      borderCardColor: ColorCommon.borderCardLightMode,
      chipColor: ColorCommon.chipLightMode,
      floatingButtonColor: ColorCommon.floatingButtonLightMode,
      buttonPrimaryColor: ColorCommon.buttonPrimaryLightMode,
      buttonSecondaryColor: ColorCommon.buttonSecondaryLightMode,
      focusButtonColor: ColorCommon.focusButtonLightMode,
    );
  }

  static ThemeData get darkTheme {
    return _buildThemeData(
      primaryColor: ColorCommon.buttonPrimaryDarkMode,
      backgroundColor: ColorCommon.backgroundDarkMode,
      textTitleColor: ColorCommon.textTitleDarkMode,
      textSubtitleColor: ColorCommon.textSubtitleDarkMode,
      appBarColor: ColorCommon.appBarDarkMode,
      iconColor: ColorCommon.iconDarkMode,
      dialogBackgroundColor: ColorCommon.dialogBackgroundColorDarkMode,
      cardColor: ColorCommon.cardDarkMode,
      borderCardColor: ColorCommon.borderCardDarkMode,
      chipColor: ColorCommon.chipDarkMode,
      floatingButtonColor: ColorCommon.floatingButtonDarkMode,
      buttonPrimaryColor: ColorCommon.buttonPrimaryDarkMode,
      buttonSecondaryColor: ColorCommon.buttonSecondaryDarkMode,
      focusButtonColor: ColorCommon.focusButtonDarkMode,
    );
  }

  static ThemeData _buildThemeData({
    required Color primaryColor,
    required Color backgroundColor,
    required Color textTitleColor,
    required Color textSubtitleColor,
    required Color appBarColor,
    required Color iconColor,
    required Color dialogBackgroundColor,
    required Color cardColor,
    required Color borderCardColor,
    required Color chipColor,
    required Color floatingButtonColor,
    required Color buttonPrimaryColor,
    required Color buttonSecondaryColor,
    required Color focusButtonColor,
  }) {
    return ThemeData(
      primaryColor: primaryColor,
      colorScheme: ColorScheme.light(primary: primaryColor),
      canvasColor: backgroundColor,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: textTitleColor),
        bodyMedium: TextStyle(color: textSubtitleColor),
      ),
      appBarTheme: AppBarTheme(
        color: appBarColor,
        iconTheme: IconThemeData(color: iconColor),
      ),
      iconTheme: IconThemeData(color: iconColor),
      dialogTheme: DialogTheme(backgroundColor: dialogBackgroundColor),
      cardTheme: CardTheme(
        color: cardColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderCardColor, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: chipColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: chipColor, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
        secondaryLabelStyle: const TextStyle(color: ColorCommon.white),
        brightness: Brightness.light,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: floatingButtonColor,
      ),
      buttonTheme: ButtonThemeData(
        colorScheme: ColorScheme.light(
          primary: buttonPrimaryColor,
          secondary: buttonSecondaryColor,
          tertiary: ColorCommon.transparent,
          onPrimary: ColorCommon.white,
          onTertiary: ColorCommon.black,
        ),
      ),
      focusColor: focusButtonColor,
    );
  }
}
