import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/device_type.dart';
import '../my_colors.dart';

class TitleTxt extends StatelessWidget {
  final String? txt;
  final Color? color;
  final TextAlign? align;

  const TitleTxt({
    super.key,
    required this.txt,
    this.color = MyColors.black,
    this.align = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    Device deviceType = DeviceType().getDeviceType(screenW);
    double fontSize;
    switch (deviceType) {
      case Device.mobile:
        fontSize = 18;
        break;
      case Device.tablet:
        fontSize = 21;
        break;
      case Device.desktop:
        fontSize = 21;
        break;
    }
    return Text(
      txt!,
      textAlign: align,
      overflow: TextOverflow.visible,
      softWrap: true,
      style: GoogleFonts.ubuntu(
        color: color,
        fontWeight: FontWeight.w700,
        fontSize: fontSize,
      ),
    );
  }
}
