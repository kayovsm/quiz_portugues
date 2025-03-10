import 'package:cloud_firestore/cloud_firestore.dart';

// CONTROLADOR DE RANKING
class RankingController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // RETORNA A LISTA DE RANKINGS
  Stream<List<Map<String, dynamic>>> getRankings() {

    // retorna uma lista dos rankings do firestore
    return _firestore.collection('ranking').snapshots().map((snapshot) {
      List<Map<String, dynamic>> rankings = snapshot.docs.map((doc) {
        return {
          'name': doc['name'],
          'correctAnswers': doc['correctAnswers'],
          'time': doc['time'],
        };
      }).toList();

      // ordena a lista de rankings
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
