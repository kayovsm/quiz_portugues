import 'package:flutter/material.dart';
import '../../controllers/ranking_controller.dart';
import '../widgets/common/assets/app/app_icon_common.dart';
import '../widgets/common/assets/asset_icon_common.dart';
import '../widgets/common/color/color_common.dart';
import '../widgets/common/text/text_common.dart';

class RankingView extends StatefulWidget {
  const RankingView({super.key});

  @override
  State<RankingView> createState() => _RankingViewState();
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
        title: TextCommon.title(text: 'Classificação'),
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
                      leadingIconColor = ColorCommon.yellow;
                    } else if (index == 1) {
                      leadingIcon = AppIconCommon.medalRanking;
                      leadingIconColor = ColorCommon.grey;
                    } else if (index == 2) {
                      leadingIcon = AppIconCommon.medalRanking;
                      leadingIconColor = ColorCommon.brown;
                    } else {
                      leadingIcon = AppIconCommon.starRanking;
                      leadingIconColor = ColorCommon.green;
                    }

                    return ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: leadingIconColor, width: 2),
                        ),
                        child: CircleAvatar(
                          backgroundColor: leadingIconColor.withOpacity(0.1),
                          child: AssetIconCommon(
                            icon: leadingIcon,
                            color: leadingIconColor,
                          ),
                        ),
                      ),
                      title: TextCommon.subtitle(text: userName),
                      subtitle: TextCommon.description(
                        text: 'Acertos: $correctAnswers, Tempo: $time',
                      ),
                    );
                  },
                );
              },
            )
          : Center(
              child: TextCommon.title(
                text:
                    'Sem conexão com a internet. Por favor, verifique sua conexão.',
                color: ColorCommon.red,
              ),
            ),
    );
  }
}
