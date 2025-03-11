import 'package:flutter/material.dart';

import '../assets/asset_icon_common.dart';
import '../color/color_common.dart';
import '../utils/util_screen_common.dart';
import '../utils/util_preference_common.dart';

class ButtonCommon {
  // CRIA UM BOTAO COM ICONE
  Widget icon({
    required String icon, // caminho para o icone a ser exibido
    required VoidCallback
        onTap, // funcao a ser chamada quando o botao for pressionado
    Color color = ColorCommon.black, // cor do icone
    double? iconH, // altura do icone
    double borderRadius = 16, // raio da borda do botao
    double margin = 0, // margem ao redor do botao
    Color background = ColorCommon.transparent, // cor de fundo do botao
    Color? borderColor, // cor da borda do botao, se houver
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(margin),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(borderRadius),
          border: borderColor != null
              ? Border.all(
                  color: borderColor,
                  width: 1,
                )
              : null,
        ),
        child: AssetIconCommon(
          icon: icon,
          color: color,
          iconHeight: iconH,
        ),
      ),
    );
  }

  // CRIA UM BOTAO COM TEXTO
  Widget text({
    required String label, // texto a ser exibido no botao
    required VoidCallback
        onTap, // funcao a ser chamada quando o botao for pressionado
    Color buttonColor = ColorCommon.black, // cor do botao
    Color labelColor = ColorCommon.white, // cor do texto do botao
    double borderRadius = 20, // raio da borda do botao
    double padding = 12, // preenchimento interno do botao
    bool oneLine = true, // define se o texto deve ser exibido em uma linha
    bool fullWidth =
        true, // define se o botao deve ocupar toda a largura disponivel
    Color? borderColor, // cor da borda do botao, se houver
  }) {
    final userPrefsController = UtilPreferenceCommon();

    return GestureDetector(
      onTap: onTap,
      child: IntrinsicWidth(
        child: Container(
          width: fullWidth ? UtilScreenCommon.screenWidth : null,
          padding: EdgeInsets.symmetric(vertical: padding),
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: borderColor != null
                ? Border.all(
                    color: borderColor,
                    width: 1,
                  )
                : null,
          ),
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: oneLine ? 1 : 2,
              style: TextStyle(
                fontFamily: 'Ubuntu',
                color: labelColor,
                fontWeight: FontWeight.w700,
                fontSize: _getFontSize(userPrefsController.fontSizeOption),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // CRIA UM BOTAO COM ICONE E TEXTO
  Widget textIcon({
    required String label, // texto a ser exibido no botao
    required VoidCallback
        onTap, // funcao a ser chamada quando o botao for pressionado
    required String icon, // caminho para o icone a ser exibido
    Color buttonColor = ColorCommon.black, // cor do botao
    Color labelColor = ColorCommon.white, // cor do texto do botao
    Color iconColor = ColorCommon.white, // cor do icone
    double? iconHeight, // altura do icone
    double borderRadius = 20, // raio da borda do botao
    bool oneLine = true, // define se o texto deve ser exibido em uma linha
    bool fullWidth =
        true, // define se o botao deve ocupar toda a largura disponivel
    Color? borderColor, // cor da borda do botao, se houver
  }) {
    final userPrefsController = UtilPreferenceCommon();

    return GestureDetector(
      onTap: onTap,
      child: IntrinsicWidth(
        child: Container(
          width: fullWidth ? UtilScreenCommon.screenWidth : null,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: borderColor != null
                ? Border.all(
                    color: borderColor,
                    width: 1,
                  )
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 16),
              AssetIconCommon(
                icon: icon,
                color: iconColor,
                iconHeight: iconHeight,
              ),
              Center(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: oneLine ? 1 : 2,
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    color: labelColor,
                    fontWeight: FontWeight.w700,
                    fontSize: _getFontSize(userPrefsController.fontSizeOption),
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }

  // RETORNA O TAMANHO DA FONTE COM BASE NA OPCAO DE TAMANHO DA FONTE FORNECIDA
  double? _getFontSize(FontSizeOption option) {
    final fontSizeMap = {
      FontSizeOption.small:
          15.0, // define o tamanho da fonte para a opcao "small"
      FontSizeOption.medium:
          16.0, // define o tamanho da fonte para a opcao "medium"
      FontSizeOption.large:
          17.0, // define o tamanho da fonte para a opcao "large"
    };

    return fontSizeMap[option] ??
        16.0; // retorna o tamanho da fonte correspondente a opcao fornecida ou 16.0 se a opcao nao for encontrada
  }
}
