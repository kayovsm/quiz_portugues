import 'package:get/get.dart';
import 'package:quiz_portugues/app/page/home_page/home_page.dart';
import 'package:quiz_portugues/app/page/questions_page/questions_page.dart';
import 'package:quiz_portugues/app/page/result_page/result_page.dart';

import '../page/login_page/login_page.dart';
import '../page/questions_tournament_page/questions_tournament_page.dart';
import '../page/ranking_page/ranking_page.dart';

class RoutesMobile {
  static const loginPage = '/loginPage';
  static const homePage = '/homePage';
  static const questionsPage = '/questionsPage';
  static const questionTournamentPage = '/questionTournamentPage';
  static const resultPage = '/resultPage';
  static const rankingPage = '/rankingPage';

  static const Transition transitionType = Transition.native;

  static final List<GetPage> pages = [
    GetPage(
      name: loginPage,
      page: () => const LoginPage(),
      transition: transitionType,
    ),
    GetPage(
      name: homePage,
      page: () => const HomePage(),
      transition: transitionType,
    ),
    GetPage(
      name: questionsPage,
      page: () => const QuestionsPage(),
      transition: transitionType,
    ),
    GetPage(
      name: questionTournamentPage,
      page: () => const QuestionsTournamentPage(),
      transition: transitionType,
    ),
    GetPage(
      name: resultPage,
      page: () => const ResultPage(),
      transition: transitionType,
    ),
    GetPage(
      name: rankingPage,
      page: () => const RankingPage(),
      transition: transitionType,
    ),
  ];
}
