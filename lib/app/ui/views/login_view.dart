import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_portugues/app/ui/widgets/common/assets/app/app_image_common.dart';
import 'package:quiz_portugues/app/ui/widgets/common/assets/asset_image_common.dart';
import 'package:quiz_portugues/app/ui/widgets/common/text/text_input_common.dart';
import '../../core/services/auth_service.dart';
import '../widgets/common/assets/app/app_icon_common.dart';
import '../widgets/common/button/button_common.dart';
import '../widgets/common/color/color_common.dart';
import '../widgets/common/text/text_common.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  late AuthService authController;

  @override
  void initState() {
    super.initState();

    authController = Get.put(AuthService());
  }

  void showBottomSheet(String action) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: ColorCommon.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextCommon.title(
              text: action == 'login' ? 'Entrar' : 'Criar Conta',
            ),
            const SizedBox(height: 20),
            TextInputCommon(
              controller: emailController,
              label: 'Usuário',
              iconLeft: AppIconCommon.accountCircle,
              onChanged: (value) {},
            ),
            TextInputCommon(
              controller: passwordController,
              label: 'Senha',
              iconLeft: AppIconCommon.logout,
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),
            if (action == 'login')
              ButtonCommon().text(
                label: 'Entrar',
                buttonColor: ColorCommon.black,
                onTap: () async {
                  String email = emailController.text.trim();
                  String emailFake = '@test.com';

                  await authController.loginUser(
                    '$email$emailFake',
                    passwordController.text.trim(),
                  );
                  Get.back();
                },
              )
            else ...[
              TextInputCommon(
                controller: confirmPasswordController,
                label: 'Confirmar Senha',
                iconLeft: AppIconCommon.logout,
                onChanged: (value) {},
              ),
              ButtonCommon().text(
                label: 'Criar Conta',
                buttonColor: ColorCommon.black,
                onTap: () async {
                  String email = emailController.text.trim();
                  String emailFake = '@test.com';

                  if (passwordController.text.trim() !=
                      confirmPasswordController.text.trim()) {
                    Get.snackbar(
                      'Erro',
                      'As senhas não conferem',
                      backgroundColor: ColorCommon.red,
                      colorText: ColorCommon.white,
                    );
                    return;
                  }

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
      backgroundColor: ColorCommon.white,
      body: SafeArea(
        child: Stack(
          children: [
            // IMAGEM DE FUNDO
            const Positioned.fill(
              child: AssetImageCommon(
                image: AppImageCommon.books,
                boxFit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: const BoxDecoration(
                  color: ColorCommon.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextCommon.title(text: 'Bem Vindo ao @Português'),
                      const Divider(),
                      const SizedBox(height: 24),
                      TextCommon.subtitle(text: 'Faça login para continuar'),
                      const SizedBox(height: 28),
                      ButtonCommon().text(
                        label: 'Entrar',
                        buttonColor: ColorCommon.black,
                        onTap: () => showBottomSheet('login'),
                      ),
                      const SizedBox(height: 8),
                      TextCommon.subtitle(text: 'Ou'),
                      const SizedBox(height: 8),
                      ButtonCommon().text(
                        label: 'Criar Conta',
                        labelColor: ColorCommon.black,
                        buttonColor: ColorCommon.transparent,
                        borderColor: ColorCommon.black,
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
