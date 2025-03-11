import 'package:flutter/material.dart';
import '../button/button_common.dart';
import '../color/color_common.dart';
import '../text/text_common.dart';
import '../utils/util_screen_common.dart';

class AlertCenterCommon {
  // metodo para selecionar opcoes
  Future<List<dynamic>?> select({
    required BuildContext context, // contexto da aplicacao
    required String title, // titulo do alerta
    required String description, // descricao do alerta
    required String leftButtonLabel, // texto do botao da esquerda
    required String rightButtonLabel, // texto do botao da direita
    required List<String> options, // lista de opcoes a serem exibidas
    required bool oneSelect, // define se apenas uma opcao pode ser selecionada
  }) {
    List<String> selectedOptions = []; // lista de opcoes selecionadas
    double screenWidth = UtilScreenCommon.screenWidth; // largura da tela
    double screenHeight = UtilScreenCommon.screenHeight; // altura da tela
    double dialogWidth =
        UtilScreenCommon.getDialogWidth(); // largura do dialogo

    return showDialog<List<dynamic>>(
      context: context,
      barrierDismissible:
          false, // impede que o dialogo seja fechado ao clicar fora dele
      builder: (BuildContext context) {
        return _buildAlertDialog(
          context: context,
          title: title,
          description: description,
          content: SingleChildScrollView(
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  children: options.map((option) {
                    return _buildOptions(
                      context,
                      option,
                      selectedOptions,
                      oneSelect,
                      (String option) {
                        setState(() {
                          if (oneSelect) {
                            selectedOptions = [option];
                          } else {
                            selectedOptions.contains(option)
                                ? selectedOptions.remove(option)
                                : selectedOptions.add(option);
                          }
                        });
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ),
          actions: [
            _buildButton(
              context: context,
              label: leftButtonLabel,
              color: Theme.of(context).buttonTheme.colorScheme!.secondary,
              onTap: () => Navigator.of(context)
                  .pop(_getResult(1, selectedOptions, oneSelect)),
            ),
            const SizedBox(width: 10), // espacamento entre os botoes
            _buildButton(
              context: context,
              label: rightButtonLabel,
              color: Theme.of(context).buttonTheme.colorScheme!.primary,
              onTap: () => Navigator.of(context)
                  .pop(_getResult(2, selectedOptions, oneSelect)),
            ),
          ],
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          dialogWidth: dialogWidth,
        );
      },
    );
  }

  // metodo para confirmar uma acao
  Future<List<dynamic>?> confirm({
    required BuildContext context, // contexto da aplicacao
    required String title, // titulo do alerta
    required String description, // descricao do alerta
    required String leftButtonLabel, // texto do botao da esquerda
    required String rightButtonLabel, // texto do botao da direita
    Color? leftButtonColor, // cor do botao da esquerda (opcional)
    Color? rightButtonColor, // cor do botao da direita (opcional)
  }) {
    double screenWidth = UtilScreenCommon.screenWidth; // largura da tela
    double screenHeight = UtilScreenCommon.screenHeight; // altura da tela
    double dialogWidth =
        UtilScreenCommon.getDialogWidth(); // largura do dialogo

    return showDialog<List<dynamic>>(
      context: context,
      barrierDismissible:
          false, // impede que o dialogo seja fechado ao clicar fora dele
      builder: (BuildContext context) {
        return _buildAlertDialog(
          context: context,
          title: title,
          description: description,
          actions: [
            _buildButton(
              context: context,
              label: leftButtonLabel,
              color: leftButtonColor ??
                  Theme.of(context).buttonTheme.colorScheme!.secondary,
              onTap: () => Navigator.of(context).pop([1, null]),
            ),
            const SizedBox(width: 10), // espacamento entre os botoes
            _buildButton(
              context: context,
              label: rightButtonLabel,
              color: rightButtonColor ??
                  Theme.of(context).buttonTheme.colorScheme!.primary,
              onTap: () => Navigator.of(context).pop([2, null]),
            ),
          ],
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          dialogWidth: dialogWidth,
        );
      },
    );
  }

  // constrói o alert dialog
  Widget _buildAlertDialog({
    required BuildContext context,
    required String title, // titulo do alerta
    required String description, // descricao do alerta
    Widget? content, // conteudo do dialogo
    required List<Widget> actions, // acoes do dialogo
    required double screenWidth, // largura da tela
    required double screenHeight, // altura da tela
    required double dialogWidth, // largura do dialogo
  }) {
    return AlertDialog(
      title: Center(
          child: TextCommon.title(text: title)), // exibe o titulo no centro
      backgroundColor: Theme.of(context)
          .dialogTheme
          .backgroundColor, // define a cor de fundo do dialogo
      content: ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight:
                screenHeight * 0.8), // limita a altura do conteudo do dialogo
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextCommon.description(text: description), // exibe a descricao
            if (content != null) Flexible(child: content), // exibe o conteudo
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center, // alinha as acoes no centro
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: actions,
        ),
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(20)), // define o raio das bordas do dialogo
      ),
      contentPadding: const EdgeInsets.all(
          20), // define o preenchimento interno do conteudo do dialogo
      insetPadding: EdgeInsets.symmetric(
        horizontal: (screenWidth - dialogWidth) /
            2, // define o preenchimento horizontal do dialogo
        vertical:
            screenHeight * 0.1, // define o preenchimento vertical do dialogo
      ),
    );
  }

  // constrói os widgets para as opcoes
  Widget _buildOptions(
    BuildContext context,
    String label, // rotulo da opcao
    List<String> selectedOptions, // lista de opcoes selecionadas
    bool oneSelect, // define se apenas uma opcao pode ser selecionada
    Function(String)
        onOptionSelected, // funcao a ser chamada quando uma opcao for selecionada
  ) {
    bool isSelected =
        selectedOptions.contains(label); // verifica se a opcao foi selecionada
    double screenWidth = MediaQuery.of(context).size.width; // largura da tela

    return GestureDetector(
      onTap: () => onOptionSelected(
          label), // aciona a funcao onOptionSelected quando a opcao e pressionada
      child: Container(
        width: screenWidth, // largura do container
        margin: const EdgeInsets.symmetric(
            vertical: 5), // define a margem vertical ao redor do container
        padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12), // define o preenchimento interno do container
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? Theme.of(context).buttonTheme.colorScheme!.primary
                : Colors.grey, // define a cor da borda do container
          ),
          borderRadius: BorderRadius.circular(
              16), // define o raio das bordas do container
          color: isSelected
              ? Theme.of(context).buttonTheme.colorScheme!.primary
              : Colors.transparent, // define a cor de fundo do container
        ),
        child: Center(
          child: TextCommon.description(
            text: label, // define o texto da opcao
            color: isSelected
                ? ColorCommon.white
                : Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color, // define a cor do texto da opcao
          ),
        ),
      ),
    );
  }

  // constrói um botao
  Widget _buildButton({
    required BuildContext context,
    required String label, // texto do botao
    required Color color, // cor do botao
    required VoidCallback
        onTap, // funcao a ser chamada quando o botao e pressionado
  }) {
    return Expanded(
      child: ButtonCommon().text(
        label: label,
        buttonColor: color,
        onTap: onTap,
      ),
    );
  }

  // obtem o resultado das opcoes selecionadas
  List<dynamic> _getResult(
      int result, List<String> selectedOptions, bool oneSelect) {
    if (selectedOptions.isEmpty) {
      return [result, null];
    }
    return [
      result,
      oneSelect ? selectedOptions.first : selectedOptions
    ]; // retorna o resultado das opcoes selecionadas
  }
}
