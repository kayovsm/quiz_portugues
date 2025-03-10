import 'package:flutter/material.dart';
import 'common/button/button_common.dart';
import 'common/color/color_common.dart';
import 'common/text/text_common.dart';

class AlertExplanationWidget extends StatelessWidget {
  final int? answerNumber;
  final String image;
  final double? height;
  final BorderRadius? borderRadius;
  final String title;
  final String explanationText;
  final VoidCallback onTap;
  final String buttonText;

  const AlertExplanationWidget({
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
    return IntrinsicHeight(
      child: IntrinsicWidth(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: ColorCommon.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/gifs/$image.gif',
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextCommon.title(text: title),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: ColorCommon.blue,
                ),
                child: TextCommon.description(
                  text: explanationText,
                  color: ColorCommon.white,
                ),
              ),
              const SizedBox(height: 30),
              ButtonCommon().text(
                onTap: () {
                  Navigator.of(context).pop();
                  onTap();
                },
                label: buttonText,
                buttonColor: ColorCommon.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
