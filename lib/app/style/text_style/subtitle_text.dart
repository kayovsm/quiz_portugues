import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/device_type.dart';
import '../my_colors.dart';

class SubTitleTxt extends StatelessWidget {
  final String? txt;
  final Color? color;
  final TextAlign? txtAlign;

  const SubTitleTxt({
    super.key,
    required this.txt,
    this.txtAlign,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    Device deviceType = DeviceType().getDeviceType(screenW);
    double fontSize;
    switch (deviceType) {
      case Device.mobile:
        fontSize = 17;
        break;
      case Device.tablet:
        fontSize = 18;
        break;
      case Device.desktop:
        fontSize = 18;
        break;
    }

    return Text(
      txt!,
      textAlign: txtAlign ?? TextAlign.start,
      style: GoogleFonts.ubuntu(
        color: color ?? MyColors.black,
        fontWeight: FontWeight.w600,
        fontSize: fontSize,
        decoration: TextDecoration.none,
      ),
    );
  }
}
