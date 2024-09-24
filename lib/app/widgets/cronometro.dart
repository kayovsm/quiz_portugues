import 'package:flutter/material.dart';

import 'botaoIrformacoesTopo.dart';
// import 'package:quiz4/app/widgets/botaoIrformacoesTopo.dart';

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
      icon: "relogio",
    );
  }
}
