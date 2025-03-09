import 'package:cloud_firestore/cloud_firestore.dart';

class RankingController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getRankings() {
    return _firestore.collection('ranking').snapshots().map((snapshot) {
      List<Map<String, dynamic>> rankings = snapshot.docs.map((doc) {
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

      return rankings;
    });
  }
}
