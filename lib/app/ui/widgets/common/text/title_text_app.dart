import 'package:flutter/material.dart';
import '../preference/user_preference.dart';

class TitleTextApp extends StatelessWidget {
  final String? text;
  final Color? color;
  final TextAlign? textAlign;
  final double? fontSize;
  final bool oneLine;

  const TitleTextApp({
    super.key,
    required this.text,
    this.color,
    this.textAlign = TextAlign.start,
    this.fontSize,
    this.oneLine = false,
  });

  @override
  Widget build(BuildContext context) {
    final userPrefsController = UserPreference();

    double fontSize;

    if (this.fontSize != null) {
      fontSize = this.fontSize!;
    } else {
      switch (userPrefsController.fontSizeOption) {
        case FontSizeOption.small:
          fontSize = 16;
          break;
        case FontSizeOption.medium:
          fontSize = 17.5;
          break;
        case FontSizeOption.large:
          fontSize = 19;
          break;
      }
    }

    return Text(
      text!,
      textAlign: textAlign,
      maxLines: oneLine ? 1 : null,
      overflow: oneLine ? TextOverflow.ellipsis : TextOverflow.visible,
      softWrap: oneLine ? false : true,
      style: TextStyle(
        fontFamily: 'Open Sans',
        color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
        fontWeight: FontWeight.w700,
        fontSize: fontSize,
      ),
    );
  }
}
