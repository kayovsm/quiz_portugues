import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_portugues/app/auth/auth_controller.dart';
import 'package:quiz_portugues/app/style/my_colors.dart';
import 'package:quiz_portugues/app/style/svg_asset.dart';
import 'package:quiz_portugues/app/style/text_style/subtitle_text.dart';
import '../../style/gradient_color.dart';
import '../../routes/routes_mobile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    GradientColor myConstants = GradientColor();
    final AuthControllerMobile authController = Get.put(AuthControllerMobile());

    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: MyColors.red,
            ),
            onPressed: () => authController.signOut(),
          ),
        ],
      ),
      body: SafeArea(
        bottom: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Image.asset(
                  'assets/img/ic_launcher.png',
                  width: 200,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildCard(
              context,
              title: 'Classificação',
              icon: 'assets/img/ranking.png',
              onTap: () => Get.toNamed(RoutesMobile.rankingPage),
            ),
            _buildCard(
              context,
              title: 'Aprender',
              icon: 'assets/img/learn.png',
              onTap: () => Get.offNamed(RoutesMobile.questionsPage),
            ),
            _buildCard(
              context,
              title: 'Desafio',
              icon: 'assets/img/challenge.png',
              onTap: () => Get.offNamed(RoutesMobile.questionTournamentPage),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required String title,
    required String icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(icon, width: 45),
              const SizedBox(width: 20),
              SubTitleTxt(txt: title),
            ],
          ),
        ),
      ),
    );
  }
}
