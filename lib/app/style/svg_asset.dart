import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/device_type.dart';

class SvgAsset extends StatelessWidget {
  final String icon;
  final Color? color;

  const SvgAsset({
    super.key,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    Device deviceType = DeviceType().getDeviceType(screenW);
    double iconH;
    switch (deviceType) {
      case Device.mobile:
        iconH = 24;
        break;
      case Device.tablet:
        iconH = 28;
        break;
      case Device.desktop:
        iconH = 38;
        break;
    }
    return SvgPicture.asset(
      'assets/icons/$icon.svg',
      height: iconH,
      color: color,
    );
  }
}