import 'package:flutter/material.dart';
import 'package:quiz_portugues/app/ui/widgets/common/assets/app/app_icon_common.dart';

import '../../controllers/ranking_controller.dart';
import '../widgets/common/assets/asset_icon_common.dart';
import '../widgets/common/color/color_app.dart';
import '../widgets/common/text/description_text_app.dart';
import '../widgets/common/text/subtitle_text_app.dart';
import '../widgets/common/text/title_text_app.dart';

class RankingView extends StatefulWidget {
  const RankingView({super.key});

  @override
  _RankingViewState createState() => _RankingViewState();
}

class _RankingViewState extends State<RankingView> {
  bool isConnected = true;
  final RankingController _rankingController = RankingController();

  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  Future<void> checkConnectivity() async {
    // var connectivityResult = await Connectivity().checkConnectivity();
    // if (connectivityResult == ConnectivityResult.none) {
    //   setState(() {
    //     isConnected = false;
    //   });
    // } else {
    //   setState(() {
    //     isConnected = true;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleTextApp(text: 'Classificação'),
      ),
      body: isConnected
          ? StreamBuilder<List<Map<String, dynamic>>>(
              stream: _rankingController.getRankings(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final rankings = snapshot.data!;

                return ListView.builder(
                  itemCount: rankings.length,
                  itemBuilder: (context, index) {
                    final ranking = rankings[index];
                    final userName = ranking['name'];
                    final correctAnswers = ranking['correctAnswers'];
                    final time = ranking['time'];

                    String leadingIcon;
                    Color leadingIconColor;
                    if (index == 0) {
                      leadingIcon = AppIconCommon.medalRanking;
                      leadingIconColor = ColorApp.yellow;
                    } else if (index == 1) {
                      leadingIcon = AppIconCommon.medalRanking;
                      leadingIconColor = ColorApp.grey;
                    } else if (index == 2) {
                      leadingIcon = AppIconCommon.medalRanking;
                      leadingIconColor = ColorApp.brown;
                    } else {
                      leadingIcon = AppIconCommon.starRanking;
                      leadingIconColor = ColorApp.green;
                    }

                    return ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: leadingIconColor, width: 2),
                        ),
                        child: CircleAvatar(
                          backgroundColor: leadingIconColor.withOpacity(0.1),
                          child: AssetIconCommon(
                            icon: leadingIcon,
                            color: leadingIconColor,
                          ),
                        ),
                      ),
                      title: SubTitleTextApp(text: userName),
                      subtitle: DescriptionTextApp(
                        text: 'Acertos: $correctAnswers, Tempo: $time',
                      ),
                    );
                  },
                );
              },
            )
          : const Center(
              child: TitleTextApp(
                text:
                    'Sem conexão com a internet. Por favor, verifique sua conexão.',
                color: ColorApp.red,
              ),
            ),
    );
  }
}
