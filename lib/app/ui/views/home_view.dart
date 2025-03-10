import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_portugues/app/core/services/auth_service.dart';
import 'package:quiz_portugues/app/ui/widgets/common/assets/app/app_image_common.dart';
import '../../controllers/learn_controller.dart';
import '../../controllers/challenge_controller.dart';
import '../../routes/routes.dart';
import '../widgets/common/assets/app/app_icon_common.dart';
import '../widgets/common/assets/asset_image_common.dart';
import '../widgets/common/button/button_common.dart';
import '../widgets/common/color/color_common.dart';
import '../widgets/common/text/text_common.dart';
import '../widgets/timer_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authController = Get.put(AuthService());

    return Scaffold(
      backgroundColor: ColorCommon.white,
      appBar: AppBar(
        title: TextCommon.title(
          text: '@Português',
          color: ColorCommon.black,
        ),
        centerTitle: true,
        actions: [
          ButtonCommon().icon(
            icon: AppIconCommon.logout,
            color: ColorCommon.red,
            onTap: () => authController.signOut(),
          )
        ],
      ),
      body: SafeArea(
        bottom: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildLogoApp(),
            _buildCard(
              context,
              title: 'Classificação',
              image: AppImageCommon.ranking,
              onTap: () => Get.toNamed(Routes.rankingView),
            ),
            _buildCard(
              context,
              title: 'Aprender',
              image: AppImageCommon.learn,
              onTap: () {
                final controller = Get.put(LearnController());

                Get.toNamed(
                  Routes.questionsView,
                  arguments: {
                    'questionCounter': '10',
                    'timerWidget': TimerWidget(
                      animation: StepTween(begin: 31, end: 0)
                          .animate(controller.animationController),
                    ),
                    'controller': controller,
                  },
                );
              },
            ),
            _buildCard(
              context,
              title: 'Desafio',
              image: AppImageCommon.challenge,
              onTap: () {
                final controller = Get.put(ChallengeController());
                Get.toNamed(
                  Routes.questionsView,
                  arguments: {
                    'questionCounter': '15',
                    'timerWidget': const TimerTournamentWidget(),
                    'controller': controller,
                  },
                );
              },
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
    required String image,
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
              AssetImageCommon(
                image: image,
                imageW: 45,
                imageH: 45,
              ),
              const SizedBox(width: 20),
              TextCommon.title(text: title),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoApp() {
    return const Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 50, bottom: 20),
        child: AssetImageCommon(
          image: AppImageCommon.logo,
          imageW: 200,
        ),
      ),
    );
  }
}
