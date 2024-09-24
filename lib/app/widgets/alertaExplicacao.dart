import 'package:flutter/material.dart';

import '../style/font_size.dart';
import '../style/image_asset.dart';
import '../style/my_colors.dart';

class ExplanationAlert extends StatelessWidget {
  final int? answerNumber;
  final String image;
  final double? height;
  final BorderRadius? borderRadius;
  final String title;
  final String explanationText;
  final VoidCallback onTap;
  final String buttonText;

  const ExplanationAlert({
    super.key,
    this.answerNumber,
    required this.title,
    required this.explanationText,
    required this.image,
    this.height,
    this.borderRadius,
    required this.onTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: MyColors.lightGrey,
      ),
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ImageAsset(
            image: image,
            imageH: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: FontSize.getFontSize(context),
                fontWeight: FontWeight.w600,
                color: MyColors.white,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: MyColors.cutGrey,
            ),
            child: Text(
              explanationText,
              style: TextStyle(
                fontSize: FontSize.getFontSize(context),
                fontWeight: FontWeight.w400,
                color: MyColors.white,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: size.width - 20,
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: MyColors.neonGreen,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  onTap();
                },
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: FontSize.getFontSize(context),
                    fontWeight: FontWeight.w700,
                    color: MyColors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
