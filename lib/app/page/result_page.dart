import 'package:flutter/material.dart';
import '../style/my_colors.dart';
import '../style/gradient_color.dart';
import '../widgets/alertaExplicacao.dart';

class AcertosTotais {
  int acertos = 0;
  AcertosTotais(this.acertos);
}

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);
  static const routeName = '/telaResultados';

  @override
  Widget build(BuildContext context) {
    final argumentos =
        ModalRoute.of(context)?.settings.arguments as AcertosTotais;

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
                // child: AlertaExplicacao(
                //   borderRadius: BorderRadius.circular(30),
                //   texto: argumentos.acertos <= 3
                //       ? "\nQue pena!"
                //       : argumentos.acertos > 3 && argumentos.acertos < 7
                //           ? "Muito bom!"
                //           : "Parabéns!",
                //   textoExplicacao:
                //       "\nVocê acertou: ${argumentos.acertos} de 10 perguntas\n",
                //   imagem: argumentos.acertos <= 3
                //       ? 'trofeu-bronze'
                //       : argumentos.acertos > 3 && argumentos.acertos < 7
                //           ? 'trofeu-prata'
                //           : 'trofeu-ouro',
                //   textoBotao: "Reiniciar",
                //   funcaoBotao: () =>
                //       Navigator.pushNamed(context, '/telaPerguntas'),
                // ),
                child: ExplanationAlert(
                  borderRadius: BorderRadius.circular(30),
                  title: argumentos.acertos <= 3
                      ? "Que pena!"
                      : argumentos.acertos > 3 && argumentos.acertos < 7
                          ? "Muito bom!"
                          : "Parabéns!",
                  explanationText:
                      "Você acertou: ${argumentos.acertos} de 10 perguntas",
                  image: argumentos.acertos <= 3
                      ? 'trofeu-bronze'
                      : argumentos.acertos > 3 && argumentos.acertos < 7
                          ? 'trofeu-prata'
                          : 'trofeu-ouro',
                  buttonText: "Reiniciar",
                  onTap: () => Navigator.pushNamed(context, '/telaPerguntas'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
