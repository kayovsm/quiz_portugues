import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../page/questions_tournament_page/questions_tournamnet_controller.dart';
import 'botaoIrformacoesTopo.dart';

class TimerWidget extends AnimatedWidget {
  TimerWidget({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  Widget build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);
    var timerText = '${clockTimer.inMinutes.remainder(60).toString()}:'
        '${(clockTimer.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';

    return TopInfoButton(
      buttonTxt: timerText,
      gif: 'hourglass',
      // icon: "timer",
    );
  }
}

class TimerTournamentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final QuestionsTournamentController controller = Get.find();

    return Obx(() {
      Duration clockTimer = controller.elapsedTime.value;
      var timerText = '${clockTimer.inMinutes.remainder(60).toString()}:' +
          '${(clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0'))}';

      return TopInfoButton(
        buttonTxt: timerText,
        icon: "timer",
      );
    });
  }
}
