import 'package:flutter/material.dart';
import '../style/font_size.dart';
import '../style/my_colors.dart';
import '../style/svg_asset.dart';

class TopInfoButton extends StatelessWidget {
  final String icon;
  final String buttonTxt;

  const TopInfoButton({
    super.key,
    required this.buttonTxt,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        color: MyColors.black,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgAsset(
                  icon: icon,
                  color: MyColors.white,
                ),
                const SizedBox(width: 5),
                Text(
                  buttonTxt,
                  style: TextStyle(
                    fontSize: FontSize.getFontSize(context),
                    fontWeight: FontWeight.w600,
                    color: MyColors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
