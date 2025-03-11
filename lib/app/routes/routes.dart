import 'package:get/get.dart';
import 'package:quiz_portugues/app/ui/views/home_view.dart';
import '../ui/views/challenge_view.dart';
import '../ui/views/learn_view.dart';
import '../ui/views/login_view.dart';
import '../ui/views/ranking_view.dart';
import '../ui/views/result_round_view.dart';

class Routes {
  static const loginView = '/loginView';
  static const homeView = '/homeView';
  static const resultRoundView = '/resultRoundView';
  static const rankingView = '/rankingView';
  static const learnView = '/learnView';
  static const challengeView = '/challengeView';

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
      name: learnView,
      page: () => LearnView(),
      transition: transitionType,
    ),
    GetPage(
      name: challengeView,
      page: () => ChallengeView(),
      transition: transitionType,
    ),
    GetPage(
      name: rankingView,
      page: () => const RankingView(),
      transition: transitionType,
    ),
  ];
}
