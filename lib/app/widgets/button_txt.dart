import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../style/my_colors.dart';
import '../style/svg_asset.dart';
import '../utils/device_type.dart';

class ButtonTxt extends StatelessWidget {
  final double? width;
  final String? txtBtn;
  final Color? btnColor;
  final Color? txtColor;
  final VoidCallback? onTap;
  final String? iconBtn;
  final double? iconH;
  final Color? iconColor;
  final double? borderRadius;

  const ButtonTxt({
    super.key,
    this.txtBtn,
    this.onTap,
    this.iconBtn,
    this.iconColor = MyColors.white,
    this.iconH,
    this.txtColor = MyColors.white,
    this.btnColor = MyColors.blue,
    this.borderRadius = 20,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final width = this.width ?? Get.width;

    return GestureDetector(
      onTap: onTap,
      child: IntrinsicWidth(
        child: Container(
          width: width,
          padding: iconBtn != null
              ? const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
              : const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          decoration: BoxDecoration(
            color: iconBtn != null && txtBtn == null
                ? MyColors.transparent
                : btnColor,
            borderRadius: BorderRadius.circular(borderRadius!),
            border: btnColor == MyColors.transparent
                ? Border.all(
                    color: MyColors.black,
                    width: 1,
                  )
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (iconBtn != null) SvgAsset(icon: iconBtn!, color: iconColor),
              if (iconBtn != null && txtBtn != null) const SizedBox(width: 5),
              if (txtBtn != null)
                Text(
                  txtBtn!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ubuntu(
                    color: txtColor,
                    fontWeight: FontWeight.w700,
                    fontSize: DeviceType().getFontSize(context),
                    decoration: TextDecoration.none,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
