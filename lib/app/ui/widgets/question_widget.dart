import 'package:flutter/material.dart';
import 'package:quiz_portugues/app/ui/widgets/common/utils/util_screen_common.dart';
import 'common/color/color_common.dart';
import 'common/text/text_common.dart';

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
    return Material(
      elevation: 50.0,
      borderRadius: BorderRadius.circular(20),
      shadowColor: Colors.black.withOpacity(1),
      child: Container(
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
              color: ColorCommon.greyLightMode,
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
      ),
    );
  }
}
