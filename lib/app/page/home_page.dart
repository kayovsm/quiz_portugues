import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_portugues/app/widgets/button_txt.dart';
import '../style/gradient_color.dart';
import '../routes/routes_mobile.dart';
import '../widgets/botaoIniciarReiniciar.dart';
import '../widgets/logoQuiz.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    GradientColor myConstants = GradientColor();
    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: Container(
          // padding: EdgeInsets.only(top: 350, bottom: 20),
          height: double.infinity,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: myConstants.gradienBackground,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 250),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const LogoQuiz(),
                // BotaoIniciarReiniciar(
                //   textoBotao: 'Iniciar',
                //   funcaoBotao: () =>
                //       Navigator.pushNamed(context, '/questionsPage'),
                //       // Get.offNamed(RoutesMobile.questionsPage)
                // ),
                ButtonTxt(
                  txtBtn: 'Iniciar',
                  onTap: () => Get.offNamed(RoutesMobile.questionsPage),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
