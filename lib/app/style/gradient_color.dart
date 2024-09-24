import 'package:flutter/cupertino.dart';

class GradientColor {
  final Gradient gradienBackground = const LinearGradient(
    colors: [Color(0xff102830), Color(0xff014550)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 1.0],
    tileMode: TileMode.clamp,
  );
  final Gradient gradienTemporizador = const LinearGradient(
    colors: [Color(0xff71d68e), Color(0xff71d68e)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.9],
    tileMode: TileMode.clamp,
  );
}
