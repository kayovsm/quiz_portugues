import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/device_type.dart';
import '../my_colors.dart';

class DescriptionTxt extends StatelessWidget {
  final String? txt;
  final Color? color;
  final TextAlign? align;
  final bool oneLine;

  const DescriptionTxt({
    super.key,
    required this.txt,
    this.color = MyColors.black,
    this.align = TextAlign.start,
    this.oneLine = false,
  });

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    Device deviceType = DeviceType().getDeviceType(screenW);
    double fontSize;
    switch (deviceType) {
      case Device.mobile:
        fontSize = 14;
        break;
      case Device.tablet:
        fontSize = 17;
        break;
      case Device.desktop:
        fontSize = 17;
        break;
    }
    return Text(
      txt!,
      textAlign: align,
      maxLines: oneLine ? 1 : null,
      style: GoogleFonts.ubuntu(
        color: color,
        fontWeight: FontWeight.w400,
        fontSize: oneLine ? fontSize - 1 : fontSize,
      ),
    );
  }
}
