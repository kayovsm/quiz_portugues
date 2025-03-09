import 'package:flutter/material.dart';

class AssetImageCommon extends StatelessWidget {
  final String image;
  final double? imageW;
  final double? imageH;
  final BoxFit? boxFit;

  const AssetImageCommon({
    super.key,
    required this.image,
    this.imageW,
    this.imageH,
    this.boxFit,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      width: imageW,
      height: imageH,
      fit: boxFit,
    );
  }
}
