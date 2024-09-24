import 'package:flutter/material.dart';
import '../style/my_colors.dart';
import '../style/text_style/title_text.dart';

class AnswerButton extends StatelessWidget {
  final String? txtBtn;
  final VoidCallback onTap;

  const AnswerButton({
    super.key,
    required this.onTap,
    required this.txtBtn,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: MyColors.black,
        ),
        child: Center(
          child: TitleTxt(
            txt: txtBtn,
            color: MyColors.white,
          ),
        ),
      ),
    );
  }
}
