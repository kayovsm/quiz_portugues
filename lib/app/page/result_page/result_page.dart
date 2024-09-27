import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_portugues/app/style/text_style/title_text.dart';

import '../../routes/routes_mobile.dart';
import '../../style/gradient_color.dart';
import '../../widgets/aleert_explanation.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final int args = Get.arguments;

    GradientColor myConstants = GradientColor();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const TitleTxt(txt: 'Resultado'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offNamed(RoutesMobile.homePage);
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(gradient: myConstants.gradienBackground),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: ExplanationAlert(
                borderRadius: BorderRadius.circular(30),
                title: 'Parabéns!',
                explanationText: "Você acertou: $args de 10 perguntas",
                image: 'podium',
                buttonText: "Reiniciar",
                onTap: () {
                  // final QuestionsController controller = Get.put(QuestionsController());
                  // controller.resetQuiz();
                  Get.offAllNamed(RoutesMobile.questionsPage);
                  // Get.offAllNamed(RoutesMobile.homePage);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
