import 'package:flutter/material.dart';
import 'package:quiz_portugues/app/ui/widgets/common/device/device_type_app.dart';
import 'common/color/color_app.dart';
import 'common/text/title_text_app.dart';

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
          color: ColorApp.white,
          border: const Border(
            top: BorderSide(
              color: Colors.black,
              width: 0.2,
            ),
          ),
          boxShadow: const [
            BoxShadow(
              color: ColorApp.greyLightMode,
              blurRadius: 5,
              offset: Offset(0, 6),
            ),
          ],
        ),
        width: DeviceTypeApp.screenWidth,
        height: height,
        child: Center(
          child: TitleTextApp(text: text),
        ),
      ),
    );
  }
}
