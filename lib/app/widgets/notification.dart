import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../style/my_colors.dart';
import '../style/svg_asset.dart';
import '../style/text_style/description_txt.dart';
import '../style/text_style/subtitle_text.dart';

class NotificationTop {
  void showNotificationTop({
    required String? icon,
    required String title,
    required String message,
    required Color bgColor,
    required Color txtColor,
  }) {
    Color? lineColor = bgColor == MyColors.pink
        ? MyColors.red
        : bgColor == MyColors.lightGreen
            ? MyColors.neonGreen
            : MyColors.cutGrey;

    Get.snackbar(
      '',
      '',
      backgroundColor: bgColor,
      duration: const Duration(seconds: 5),
      snackPosition: SnackPosition.TOP,
      padding: const EdgeInsets.all(0),
      borderRadius: 10,
      borderWidth: 1,
      borderColor: MyColors.black,
      titleText: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: SvgAsset(icon: icon, color: MyColors.black),
              ),
            SubTitleTxt(color: txtColor, txt: title),
          ],
        ),
      ),
      messageText: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 6),
            child: DescriptionTxt(txt: message, color: txtColor),
          ),
          Container(
            height: 12,
            decoration: BoxDecoration(
              color: lineColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void loginError() {
    NotificationTop().showNotificationTop(
      icon: 'info',
      title: 'Login Falhou',
      message: 'Usuário ou senha incorretos!',
      bgColor: MyColors.pink,
      txtColor: MyColors.black,
    );
  }

  void createError() {
    NotificationTop().showNotificationTop(
      icon: 'info',
      title: 'Flha ao criar usuário',
      message: 'Nome de usuário já existe!',
      bgColor: MyColors.pink,
      txtColor: MyColors.black,
    );
  }

  void viewPdf() {
    NotificationTop().showNotificationTop(
      icon: 'info',
      title: 'Atenção',
      message: 'Preencha todos os campos para gerar o PDF',
      bgColor: MyColors.pink,
      txtColor: MyColors.black,
    );
  }

  void searchNotFound({required String title, required String message}) {
    NotificationTop().showNotificationTop(
      icon: 'info',
      title: title,
      message: message,
      bgColor: MyColors.pink,
      txtColor: MyColors.black,
    );
  }

  void success({required String title, required String message}) {
    NotificationTop().showNotificationTop(
      icon: 'check_circle',
      title: title,
      message: message,
      bgColor: MyColors.lightGreen,
      txtColor: MyColors.black,
    );
  }

  void error({required String title, required String message}) {
    NotificationTop().showNotificationTop(
      icon: 'info',
      title: title,
      message: message,
      bgColor: MyColors.pink,
      txtColor: MyColors.black,
    );
  }

  void warning({required String title, required String message}) {
    NotificationTop().showNotificationTop(
      icon: 'info',
      title: title,
      message: message,
      bgColor: const Color.fromARGB(255, 0, 157, 254),
      txtColor: MyColors.black,
    );
  }
}
