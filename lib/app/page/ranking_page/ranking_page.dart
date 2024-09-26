import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_portugues/app/style/my_colors.dart';
import 'package:quiz_portugues/app/style/svg_asset.dart';
import 'package:quiz_portugues/app/style/text_style/description_txt.dart';
import 'package:quiz_portugues/app/style/text_style/subtitle_text.dart';
import 'package:quiz_portugues/app/style/text_style/title_text.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleTxt(txt: 'Classificação'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('ranking').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final rankings = snapshot.data!.docs.map((doc) {
            return {
              'name': doc['name'],
              'correctAnswers': doc['correctAnswers'],
              'time': doc['time'],
            };
          }).toList();

          // Ordenar os rankings manualmente
          rankings.sort((a, b) {
            if (a['correctAnswers'] != b['correctAnswers']) {
              return b['correctAnswers'].compareTo(a['correctAnswers']);
            } else {
              return a['time'].compareTo(b['time']);
            }
          });

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
                leadingIcon = 'medal_ranking';
                leadingIconColor = MyColors.gold;
              } else if (index == 1) {
                leadingIcon = 'medal_ranking';
                leadingIconColor = MyColors.silver;
              } else if (index == 2) {
                leadingIcon = 'medal_ranking';
                leadingIconColor = MyColors.bronze;
              } else {
                leadingIcon = 'star_ranking';
                leadingIconColor = MyColors.neonGreen;
              }

              return ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: leadingIconColor, width: 1.0),
                  ),
                  child: CircleAvatar(
                    backgroundColor: MyColors.transparent,
                    child: SvgAsset(
                      icon: leadingIcon,
                      color: leadingIconColor,
                    ),
                  ),
                ),
                title: SubTitleTxt(txt: userName),
                subtitle: DescriptionTxt(
                    txt: 'Acertos: $correctAnswers, Tempo: $time'),
              );
            },
          );
        },
      ),
    );
  }
}
