import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../preference/user_preference.dart';

class AssetIconCommon extends StatelessWidget {
  final String icon;
  final Color? color;
  final double? iconHeight;

  const AssetIconCommon({
    super.key,
    required this.icon,
    this.iconHeight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final userPrefsController = UserPreference();

    final fontSizeMap = {
      FontSizeOption.small: 24.0,
      FontSizeOption.medium: 28.0,
      FontSizeOption.large: 32.0,
    };

    final iconH = fontSizeMap[userPrefsController.fontSizeOption] ?? 28.0;

    return SvgPicture.asset(
      icon,
      height: iconHeight ?? iconH,
      colorFilter: ColorFilter.mode(
        color ?? Theme.of(context).iconTheme.color!,
        BlendMode.srcIn,
      ),
    );
  }
}
