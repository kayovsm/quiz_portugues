import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_portugues/app/ui/widgets/common/assets/app/app_icon_common.dart';
import '../../controllers/challenge_controller.dart';
import 'common/assets/asset_icon_common.dart';
import 'common/color/color_app.dart';
import 'common/text/subtitle_text_app.dart';

class TimerWidget extends AnimatedWidget {
  const TimerWidget({super.key, required this.animation})
      : super(listenable: animation);

  final Animation<int> animation;

  @override
  Widget build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);
    var timerText = '${clockTimer.inMinutes.remainder(60).toString()}:'
        '${(clockTimer.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';

    return _buildTopInfoSection(AppIconCommon.timer, timerText, '');
  }
}

class TimerTournamentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ChallengeController controller = Get.find();

    return Obx(() {
      Duration clockTimer = controller.elapsedTime.value;
      var timerText = '${clockTimer.inMinutes.remainder(60).toString()}:' +
          '${(clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0'))}';

      return _buildTopInfoSection(AppIconCommon.timer, timerText, '');
    });
  }
}

Widget _buildTopInfoSection(String? icon, String buttonTxt, String? gif) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
    decoration: BoxDecoration(
      color: ColorApp.white,
      borderRadius: BorderRadius.circular(50),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (icon != null)
          const AssetIconCommon(
            icon: AppIconCommon.timer,
            color: ColorApp.black,
          ),
        const SizedBox(width: 5),
        SubTitleTextApp(text: buttonTxt)
      ],
    ),
  );
}
