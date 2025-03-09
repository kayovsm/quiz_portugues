import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_portugues/app/ui/widgets/common/assets/app/app_image_common.dart';
import 'package:quiz_portugues/app/ui/widgets/common/assets/asset_image_common.dart';
import 'package:quiz_portugues/app/ui/widgets/common/text/input_text_app.dart';
import '../../core/services/auth_service.dart';
import '../widgets/common/assets/app/app_icon_common.dart';
import '../widgets/common/button/button_common.dart';
import '../widgets/common/color/color_app.dart';
import '../widgets/common/text/subtitle_text_app.dart';
import '../widgets/common/text/title_text_app.dart';

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
          color: ColorApp.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleTextApp(
              text: action == 'login' ? 'Entrar' : 'Criar Conta',
            ),
            const SizedBox(height: 20),
            InputTextApp(
              controller: emailController,
              label: 'Usuário',
              iconLeft: AppIconCommon.accountCircle,
              onChanged: (value) {},
            ),
            InputTextApp(
              controller: passwordController,
              label: 'Senha',
              iconLeft: AppIconCommon.logout,
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),
            if (action == 'login')
              ButtonCommon().text(
                label: 'Entrar',
                buttonColor: ColorApp.black,
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
              InputTextApp(
                controller: confirmPasswordController,
                label: 'Confirmar Senha',
                iconLeft: AppIconCommon.logout,
                onChanged: (value) {},
              ),
              ButtonCommon().text(
                label: 'Criar Conta',
                buttonColor: ColorApp.black,
                onTap: () async {
                  String email = emailController.text.trim();
                  String emailFake = '@test.com';

                  if (passwordController.text.trim() !=
                      confirmPasswordController.text.trim()) {
                    Get.snackbar(
                      'Erro',
                      'As senhas não conferem',
                      backgroundColor: ColorApp.red,
                      colorText: ColorApp.white,
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
      backgroundColor: ColorApp.white,
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
                  color: ColorApp.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TitleTextApp(text: 'Bem Vindo ao @Português'),
                      const Divider(),
                      const SizedBox(height: 24),
                      const SubTitleTextApp(text: 'Faça login para continuar'),
                      const SizedBox(height: 28),
                      ButtonCommon().text(
                        label: 'Entrar',
                        buttonColor: ColorApp.black,
                        onTap: () => showBottomSheet('login'),
                      ),
                      const SizedBox(height: 8),
                      const SubTitleTextApp(text: 'Ou'),
                      const SizedBox(height: 8),
                      ButtonCommon().text(
                        label: 'Criar Conta',
                        labelColor: ColorApp.black,
                        buttonColor: ColorApp.transparent,
                        borderColor: ColorApp.black,
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
