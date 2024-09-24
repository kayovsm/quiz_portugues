import 'package:flutter/material.dart';

class MyColors {
  MyColors._privateConstructor();

  static final MyColors _instance = MyColors._privateConstructor();

  factory MyColors() {
    return _instance;
  }

  static const cutGrey = Color(0xff3b4e55);
  static const lightGrey = Color(0xFF151B2B);
  static const blue = Color(0xFF03A9F4);
  static const white = Color(0xFFfefefe);
  static const black = Color(0xFF2C2D33);
  static const neonGreen = Color(0xFF59B172);
  static const orange = Color(0xFFF89320);
  static const darkGreen = Color(0xFF014550);
  static const blackGreen = Color(0xFF102830);
  static const transparent = Colors.transparent;
}
