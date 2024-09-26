import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/routes_mobile.dart';
import '../../style/my_colors.dart';
import '../../style/gradient_color.dart';
import '../../widgets/alertaExplicacao.dart';

// class AcertosTotais {
//   int acertos = 0;
//   AcertosTotais(this.acertos);
// }

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);
  // static const routeName = '/telaResultados';

  @override
  Widget build(BuildContext context) {
    final int args = Get.arguments;

    GradientColor myConstants = GradientColor();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Container(
            height: size.height,
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(gradient: myConstants.gradienBackground),
            child: Padding(
              padding: const EdgeInsets.only(top: 180, bottom: 180),
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: MyColors.blackGreen,
                  border: Border.all(
                    color: MyColors.neonGreen,
                  ),
                ),
                child: ExplanationAlert(
                  borderRadius: BorderRadius.circular(30),
                  title: args <= 3
                      ? "Que pena!"
                      : args > 3 && args < 7
                          ? "Muito bom!"
                          : "Parabéns!",
                  explanationText:
                      "Você acertou: ${args} de 10 perguntas",
                  image: args <= 3
                      ? 'trofeu-bronze'
                      : args > 3 && args < 7
                          ? 'trofeu-prata'
                          : 'trofeu-ouro',
                  buttonText: "Reiniciar",
                  onTap: () => Get.offNamed(RoutesMobile.questionsPage),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
