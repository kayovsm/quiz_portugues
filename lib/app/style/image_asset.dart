import 'package:flutter/material.dart';

class ImageAsset extends StatelessWidget {
  final String image;
  final double? imageW;
  final double? imageH;
  final BoxFit? boxFit;

  const ImageAsset(
      {Key? key, required this.image, this.imageW, this.imageH, this.boxFit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/img/$image.png',
      width: imageW,
      height: imageH,
      fit: boxFit,
    );
  }
}
