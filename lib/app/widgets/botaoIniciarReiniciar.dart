import 'package:flutter/material.dart';

import '../style/my_colors.dart';
import '../style/font_size.dart';

class BotaoIniciarReiniciar extends StatelessWidget {
  final String textoBotao;
  final funcaoBotao;

  const BotaoIniciarReiniciar({
    super.key,
    this.funcaoBotao,
    required this.textoBotao,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: funcaoBotao,
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            height: 50,
            width: MediaQuery.of(context).size.width,
            color: MyColors.neonGreen,
            child: Center(
              child: Text(
                textoBotao,
                style: TextStyle(
                  color: MyColors.white,
                  fontSize: FontSize.getFontSize(context),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
