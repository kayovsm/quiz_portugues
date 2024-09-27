import 'package:flutter/material.dart';
import 'package:quiz_portugues/app/style/text_style/subtitle_text.dart';
import 'package:quiz_portugues/app/style/text_style/title_text.dart';
import 'package:quiz_portugues/app/widgets/button_txt.dart';

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
    // Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: MyColors.white,
      ),
      // height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ImageAsset(
          //   image: image,
          //   imageH: 100,
          // ),
          Image.asset(
            'assets/gifs/$image.gif',
            height: 150,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TitleTxt(txt: title),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: MyColors.blue,
            ),
            child: SubTitleTxt(
              txt: explanationText,
              color: MyColors.white,
            ),
          ),
          const SizedBox(height: 30),
          ButtonTxt(
            txtBtn: buttonText,
            onTap: () {
              Navigator.of(context).pop();
              onTap();
            },
            btnColor: MyColors.black,
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Container(
          //     width: size.width - 20,
          //     margin: const EdgeInsets.only(top: 30),
          //     padding: const EdgeInsets.symmetric(vertical: 12),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(30),
          //       color: MyColors.neonGreen,
          //     ),
          //     child: InkWell(
          //       onTap: () {
          //         Navigator.of(context).pop();
          //         onTap();
          //       },
          //       child: Text(
          //         buttonText,
          //         style: TextStyle(
          //           fontSize: FontSize.getFontSize(context),
          //           fontWeight: FontWeight.w700,
          //           color: MyColors.white,
          //         ),
          //         textAlign: TextAlign.center,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
