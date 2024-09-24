import 'package:get/get.dart';
import 'package:quiz_portugues/app/page/home_page.dart';
import 'package:quiz_portugues/app/page/questions_page/questions_page.dart';
import 'package:quiz_portugues/app/page/result_page.dart';

class RoutesMobile {
  static const homePage = '/homePage';
  static const questionsPage = '/questionsPage';
  static const resultPage = '/resultPage';

  static const Transition transitionType = Transition.native;

  static final List<GetPage> pages = [
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
      name: resultPage,
      page: () => const ResultPage(),
      transition: transitionType,
    ),
  ];
}
