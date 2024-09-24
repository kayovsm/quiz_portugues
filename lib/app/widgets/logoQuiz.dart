import 'package:flutter/material.dart';

import '../style/image_asset.dart';

class LogoQuiz extends StatelessWidget {
  const LogoQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 160,
      decoration: BoxDecoration(
        color: Colors.deepPurple[50],
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(170, 6, 8, 19),
            offset: Offset(5.0, 5.0),
            blurRadius: 15,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Color.fromARGB(255, 60, 52, 82),
            offset: Offset(-5.0, -5.0),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: const ImageAsset(
        image: "logo_quiz",
        imageH: 100,
      ),
    );
  }
}
