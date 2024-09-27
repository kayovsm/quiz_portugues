/*

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../auth/auth_controller.dart';
import '../../style/my_colors.dart';
import '../../widgets/button_txt.dart';
import '../../widgets/rounded_input.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  late AuthControllerMobile authController;

  @override
  void initState() {
    super.initState();

    authController = Get.put(AuthControllerMobile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const ImgAsset(
                //   // img: "brasao_pmma.png",
                //   img: "logo_pmma.bmp",
                //   imgH: 170,
                // ),
                const SizedBox(height: 30),
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
                const SizedBox(height: 30),
                ButtonTxt(
                  txtBtn: 'Criar',
                  onTap: () async {
                    String email = emailController.text.trim();
                    String emailFake = '@test.com';

                    await authController.createUser(
                      '$email$emailFake',
                      passwordController.text.trim(),
                      'Teste Name'
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/