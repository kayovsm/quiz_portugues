import 'package:get/get.dart';
import 'package:quiz_portugues/app/ui/views/home_view.dart';
import 'package:quiz_portugues/app/ui/views/questions_view.dart';

import '../ui/views/login_view.dart';
import '../ui/views/ranking_view.dart';
import '../ui/views/result_round_view.dart';

class Routes {
  static const loginView = '/loginView';
  static const homeView = '/homeView';
  static const resultRoundView = '/resultRoundView';
  static const rankingView = '/rankingView';
  static const questionsView = '/questionsView';

  static const Transition transitionType = Transition.native;

  static final List<GetPage> pages = [
    GetPage(
      name: loginView,
      page: () => const LoginView(),
      transition: transitionType,
    ),
    GetPage(
      name: homeView,
      page: () => const HomeView(),
      transition: transitionType,
    ),
    GetPage(
      name: resultRoundView,
      page: () => ResultRoundView(),
      transition: transitionType,
    ),
    GetPage(
      name: questionsView,
      page: () => QuestionsView(),
    ),
    GetPage(
      name: rankingView,
      page: () => const RankingView(),
      transition: transitionType,
    ),
  ];
}
