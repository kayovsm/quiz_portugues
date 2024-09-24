import 'package:flutter/material.dart';

class FontSize {
  static double getFontSize(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (width > 400 && height > 750) {
      return 22;
    }
    if (width > 350 && height > 600) {
      return 19;
    }
    if (width < 350 && height < 600) {
      return 16;
    } 
    else {
      return 12;
    }
  }
}
