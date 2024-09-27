import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_portugues/app/style/text_style/subtitle_text.dart';
import 'package:quiz_portugues/app/style/text_style/title_text.dart';

import '../../auth/auth_controller.dart';
import '../../routes/routes_mobile.dart';
import '../../style/my_colors.dart';
import '../../widgets/button_txt.dart';
import '../../widgets/rounded_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  late AuthControllerMobile authController;

  @override
  void initState() {
    super.initState();

    authController = Get.put(AuthControllerMobile());
  }

  void showBottomSheet(String action) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleTxt(
              txt: action == 'login' ? 'Entrar' : 'Criar Conta',
            ),
            const SizedBox(height: 20),
            if (action == 'login') ...[
              RoundedInputIcon(
                controller: emailController,
                hintTxt: 'Usuário',
                icon: Icons.person_rounded,
                onChanged: (value) {},
              ),
              RoundedInputIcon(
                controller: passwordController,
                hintTxt: 'Senha',
                icon: Icons.lock_clock_outlined,
                onChanged: (value) {},
              ),
              const SizedBox(height: 20),
              ButtonTxt(
                txtBtn: 'Entrar',
                btnColor: MyColors.black,
                onTap: () async {
                  String email = emailController.text.trim();
                  String emailFake = '@test.com';

                  await authController.loginUser(
                    '$email$emailFake',
                    passwordController.text.trim(),
                  );
                  Get.back();
                },
              ),
            ] else ...[
              RoundedInputIcon(
                controller: emailController,
                hintTxt: 'Usuário',
                icon: Icons.person_rounded,
                onChanged: (value) {},
              ),
              RoundedInputIcon(
                controller: passwordController,
                hintTxt: 'Senha',
                icon: Icons.lock_clock_outlined,
                onChanged: (value) {},
              ),
              const SizedBox(height: 20),
              ButtonTxt(
                txtBtn: 'Criar Conta',
                btnColor: MyColors.black,
                onTap: () async {
                  String email = emailController.text.trim();
                  String emailFake = '@test.com';

                  await authController.createUser(
                    '$email$emailFake',
                    passwordController.text.trim(),
                    email,
                  );
                  Get.back();
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Imagem de fundo
            Positioned.fill(
              child: Image.asset(
                'assets/img/book4.jpg',
                fit: BoxFit.cover,
              ),
            ),
            /*
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Image.asset(
                  'assets/img/ic_launcher.png',
                  width: 200,
                ),
              ),
            ),
            */
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: const BoxDecoration(
                  color: MyColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TitleTxt(txt: 'Bem Vindo ao @Português'),
                      const SizedBox(height: 30),
                      const SubTitleTxt(txt: 'Faça login para continuar'),
                      const SizedBox(height: 6),
                      ButtonTxt(
                        txtBtn: 'Entrar',
                        btnColor: MyColors.black,
                        onTap: () => showBottomSheet('login'),
                      ),
                      const SizedBox(height: 6),
                      const SubTitleTxt(txt: 'Ou'),
                      const SizedBox(height: 6),
                      ButtonTxt(
                        txtBtn: 'Criar Conta',
                        txtColor: MyColors.black,
                        btnColor: MyColors.transparent,
                        onTap: () => showBottomSheet('create'),
                      ),
                    ],
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
