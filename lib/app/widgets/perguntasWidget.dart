import 'package:flutter/material.dart';

import '../style/my_colors.dart';
import '../style/font_size.dart';
import '../style/text_style/title_text.dart';

class QuestionWidget extends StatelessWidget {
  final String txt;
  final double height;

  const QuestionWidget({
    super.key,
    required this.height,
    required this.txt,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Material(
      elevation: 50.0, // Ajuste a elevação conforme necessário
      borderRadius: BorderRadius.circular(20),
      shadowColor: Colors.black.withOpacity(1), // Ajuste a cor da sombra se necessário
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: MyColors.white,
        ),
        width: size.width,
        height: height,
        child: Center(
          child: TitleTxt(
            txt: txt,
            color: MyColors.black,
          ),
        ),
      ),
    );
  }
}