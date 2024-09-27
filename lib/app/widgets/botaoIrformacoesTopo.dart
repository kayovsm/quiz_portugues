import 'package:flutter/material.dart';
import 'package:quiz_portugues/app/style/text_style/subtitle_text.dart';
import '../style/my_colors.dart';
import '../style/svg_asset.dart';

class TopInfoButton extends StatelessWidget {
  final String? icon;
  final String buttonTxt;
  final String? gif;

  const TopInfoButton({
    super.key,
    required this.buttonTxt,
    this.icon,
    this.gif,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (gif != null)
            Image.asset(
              'assets/gifs/$gif.gif',
              height: 24,
            ),
          if (icon != null)
            SvgAsset(
              icon: icon!,
              color: MyColors.black,
            ),
          const SizedBox(width: 5),
          SubTitleTxt(txt: buttonTxt)
        ],
      ),
    );
  }
}
