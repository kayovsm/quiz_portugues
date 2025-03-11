import 'package:flutter/material.dart';
import 'common/color/color_common.dart';
import 'common/text/text_common.dart';
import 'common/utils/util_screen_common.dart';

class QuestionWidget extends StatelessWidget {
  final String text;
  final double height;

  const QuestionWidget({
    super.key,
    required this.height,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorCommon.white,
        border: const Border(
          top: BorderSide(
            color: Colors.black,
            width: 0.2,
          ),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 225, 223, 223),
            blurRadius: 5,
            offset: Offset(0, 6),
          ),
        ],
      ),
      width: UtilScreenCommon.screenWidth,
      height: height,
      child: Center(
        child: TextCommon.title(text: text),
      ),
    );
  }
}
