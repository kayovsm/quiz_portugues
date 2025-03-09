import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/learn_controller.dart';
import '../../controllers/challenge_controller.dart';
import '../../routes/routes.dart';
import '../widgets/alert_explanation_widget.dart';
import '../widgets/common/assets/app/app_icon_common.dart';
import '../widgets/common/button/button_common.dart';
import '../widgets/common/color/color_app.dart';
import '../widgets/common/text/title_text_app.dart';
import '../widgets/timer_widget.dart';

class ResultRoundView extends StatelessWidget {
  final String? type;
  final int? correctAnswers;

  ResultRoundView({super.key})
      : type = Get.arguments['type'],
        correctAnswers = Get.arguments['correctAnswers'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.blue,
      appBar: AppBar(
        title: const TitleTextApp(
          text: 'Resultado',
          color: ColorApp.white,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: ButtonCommon().icon(
          icon: AppIconCommon.arrowBack,
          color: ColorApp.white,
          onTap: () => Get.offNamed(Routes.homeView),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: AlertExplanationWidget(
                borderRadius: BorderRadius.circular(30),
                title: 'Parabéns!',
                explanationText:
                    "Você acertou: $correctAnswers de 10 perguntas",
                image: 'podium',
                buttonText: "Reiniciar",
                onTap: () {
                  if (type == 'tournament') {
                    final controller = Get.put(ChallengeController());
                    Get.offAllNamed(
                      Routes.questionsView,
                      arguments: {
                        'questionCounter': '15',
                        'timerWidget': TimerTournamentWidget(),
                        'controller': controller,
                      },
                    );
                  } else {
                    final controller = Get.put(LearnController());
                    Get.offAllNamed(
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
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
