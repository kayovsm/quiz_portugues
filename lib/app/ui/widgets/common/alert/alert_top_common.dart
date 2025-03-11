import 'package:flutter/material.dart';
import '../assets/app/app_icon_common.dart';
import '../assets/asset_icon_common.dart';
import '../color/color_common.dart';
import '../text/text_common.dart';

class AlertTopCommon {
  // exibe uma notificacao no topo da tela
  void showNotificationTop({
    required BuildContext context, // contexto da aplicacao
    required String? icon, // icone da notificacao
    required String title, // titulo da notificacao
    required String description, // descricao da notificacao
    required Color backgroundColor, // cor de fundo da notificacao
    required Color textColor, // cor do texto da notificacao
  }) {
    final overlay = Overlay.of(context); // obtem o overlay da aplicacao
    late OverlayEntry overlayEntry; // cria um overlay entry
    ValueNotifier<double> topPosition =
        ValueNotifier<double>(-100); // inicialmente invisível

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            ValueListenableBuilder<double>(
              valueListenable: topPosition, // escuta as mudanças na posição
              builder: (context, value, child) {
                return AnimatedPositioned(
                  duration: const Duration(
                      milliseconds: 1000), // define a duracao da animacao
                  curve: Curves.easeOut, // define a curva da animacao
                  top: value, // posicao vertical
                  left: 20.0, // margem esquerda
                  right: 20.0, // margem direita
                  child: Material(
                    color: Colors
                        .transparent, // define a cor transparente para o material
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal:
                              10), // define o preenchimento interno do container
                      decoration: BoxDecoration(
                        color:
                            backgroundColor, // define a cor de fundo do container
                        borderRadius: BorderRadius.circular(
                            16), // define o raio das bordas do container
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AssetIconCommon(
                                icon: icon!, // define o icone
                                color: ColorCommon.white,
                              ),
                              TextCommon.subtitle(
                                color:
                                    textColor, // define a cor do texto do titulo
                                text: title, // define o titulo da notificacao
                              ),
                            ],
                          ),
                          TextCommon.description(
                            text:
                                description, // define a descricao da notificacao
                            color:
                                textColor, // define a cor do texto da descricao
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );

    topPosition.value = -100; // inicialmente invisível
    overlay.insert(overlayEntry); // insere o overlay entry

    // garante que a animacao de entrada seja disparada apos o primeiro frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      topPosition.value = 20; // posicao visível
    });

    // aguarda 3 segundos antes de iniciar a animacao de saida
    Future.delayed(const Duration(seconds: 3), () {
      topPosition.value = -100; // posicao invisível

      Future.delayed(const Duration(milliseconds: 500), () {
        overlayEntry.remove(); // remove o overlay entry
      });
    });
  }

  // exibe uma notificacao de sucesso
  void success({
    required BuildContext context, // contexto da aplicacao
    required String title, // titulo da notificacao
    required String message, // mensagem da notificacao
  }) {
    final isDarkTheme = Theme.of(context).brightness ==
        Brightness.dark; // verifica se o tema é escuro
    showNotificationTop(
      context: context,
      icon: AppIconCommon.checkCircle, // define o icone de sucesso
      title: title, // define o titulo da notificacao
      description: message, // define a mensagem da notificacao
      backgroundColor: isDarkTheme
          ? ColorCommon.alertSuccessLightMode
          : ColorCommon
              .alertSuccessLightMode, // define a cor de fundo da notificacao
      textColor: isDarkTheme
          ? ColorCommon.white
          : ColorCommon.white, // define a cor do texto da notificacao
    );
  }

  // exibe uma notificacao de erro
  void error({
    required BuildContext context, // contexto da aplicacao
    required String title, // titulo da notificacao
    required String message, // mensagem da notificacao
  }) {
    final isDarkTheme = Theme.of(context).brightness ==
        Brightness.dark; // verifica se o tema é escuro
    showNotificationTop(
      context: context,
      icon: AppIconCommon.info, // define o icone de erro
      title: title, // define o titulo da notificacao
      description: message, // define a mensagem da notificacao
      backgroundColor: isDarkTheme
          ? ColorCommon.alertErrorDarkMode
          : ColorCommon
              .alertErrorLightMode, // define a cor de fundo da notificacao
      textColor: isDarkTheme
          ? ColorCommon.white
          : ColorCommon.white, // define a cor do texto da notificacao
    );
  }
}
