import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../assets/app/app_icon_common.dart';
import '../color/color_common.dart';
import '../utils/util_screen_common.dart';
import 'text_common.dart';

/// widget de campo de entrada de texto comum
class TextInputCommon extends StatelessWidget {
  final String label; // rótulo do campo de texto
  final double? width; // largura do campo de texto
  final TextEditingController controller; // controlador do texto
  final ValueChanged<String>? onChanged; // função chamada quando o texto muda
  final TextInputType? keyboardType; // tipo de teclado
  final int? maxChar; // número máximo de caracteres
  final FocusNode? focusNode; // nó de foco
  final bool isRequired; // indica se o campo é obrigatório
  final String? iconLeft; // ícone à esquerda
  final Widget? iconRight; // ícone à direita
  final TextInputFormatter? inputFormatter; // formatador de entrada
  final bool isPassword; // indica se o campo é uma senha

  const TextInputCommon({
    super.key,
    this.width,
    required this.label,
    this.onChanged,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.maxChar,
    this.focusNode,
    this.isRequired = false,
    this.iconLeft,
    this.iconRight,
    this.inputFormatter,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = UtilScreenCommon.screenWidth;
    Device deviceType = UtilScreenCommon.getDeviceType();
    double maxW;

    // define a largura máxima com base no tipo de dispositivo
    switch (deviceType) {
      case Device.mobile:
        maxW = screenWidth;
        break;
      case Device.tablet:
        maxW = screenWidth;
        break;
      case Device.desktop:
        maxW = 600;
        break;
    }

    bool required = isRequired ? controller.text.isEmpty : false;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxW),
      child: Container(
        width: width ?? screenWidth,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                cursorColor: Theme.of(context).textTheme.bodyMedium!.color!,
                obscureText: isPassword,
                maxLength: maxChar,
                maxLines: isPassword ? 1 : null,
                controller: controller,
                onChanged: onChanged,
                keyboardType: keyboardType,
                focusNode: focusNode,
                scrollPadding: const EdgeInsets.all(0),
                inputFormatters: [
                  if (inputFormatter != null) inputFormatter!,
                  NoLeadingSpacesFormatter(),
                ],
                decoration: InputDecoration(
                  filled: true,
                  // exibe ícone de aviso se o campo é obrigatório e está vazio
                  prefixIcon: required
                      ? Padding(
                          padding: const EdgeInsetsDirectional.all(12),
                          child: SvgPicture.asset(
                            AppIconCommon.warningAmber,
                            height: 22,
                            // cor: ColorCommon.red,
                            colorFilter: const ColorFilter.mode(
                              ColorCommon.red,
                              BlendMode.srcIn,
                            ),
                          ),
                        )
                      // exibe ícone à esquerda se fornecido
                      : iconLeft != null
                          ? Padding(
                              padding: const EdgeInsetsDirectional.all(12),
                              child: SvgPicture.asset(
                                iconLeft!,
                                height: 22,
                                // cor: ColorCommon.grey,
                                colorFilter: const ColorFilter.mode(
                                  ColorCommon.grey,
                                  BlendMode.srcIn,
                                ),
                              ),
                            )
                          : null,
                  suffixIcon: iconRight, // ícone à direita se fornecido
                  fillColor: ColorCommon.transparent,
                  label: TextCommon.description(
                    text: label,
                    color: Theme.of(context).textTheme.bodyMedium!.color!,
                  ),
                  counterText: '',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Theme.of(context).textTheme.bodyMedium!.color!,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Theme.of(context).buttonTheme.colorScheme!.primary,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// remove espaços no início do texto
class NoLeadingSpacesFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text.trimLeft(); // remove espaços à esquerda
    int offset = newValue.selection.baseOffset -
        (newValue.text.length - newText.length); // ajusta a posição do cursor
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: offset),
    );
  }
}
