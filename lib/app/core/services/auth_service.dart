import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/database/user_db.dart';
import '../../routes/routes.dart';
import '../../ui/widgets/common/alert/alert_top_common.dart';

class AuthService extends GetxController {
  // variavel reativa que armazena o usuario atual
  Rx<User?> _user = Rx<User?>(FirebaseAuth.instance.currentUser);

  // retorna o usuario atual
  User? get user => _user.value;
  FirebaseAuth auth = FirebaseAuth.instance; // instancia do FirebaseAuth
  FirebaseFirestore firestore = FirebaseFirestore.instance; // instancia do FirebaseFirestore

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser); // inicializa a variavel _user com o usuario atual
    _user.bindStream(auth.userChanges()); // vincula a variavel _user ao stream de mudanças de usuario
    ever(_user, checkLogin); // verifica o login sempre que _user mudar
  }

  // verifica o estado de login do usuario
  void checkLogin(User? user) {
    if (user == null && _user.value != null) {
      Get.offAllNamed(Routes.loginView); // redireciona para a tela de login se o usuario nao estiver logado
    } else if (user != null) {
      Get.offNamed(Routes.homeView); // redireciona para a tela principal se o usuario estiver logado
    }
  }

  // faz login do usuario com email e senha
  Future<void> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ); // faz login com email e senha
      bool isLogin = await saveUserDataDB(userCredential.user!.uid); // salva os dados do usuario no banco de dados
      if (isLogin) {
        Get.offAllNamed(Routes.homeView); // redireciona para a tela principal se o login for bem-sucedido
      } else {
        showError('Erro', 'Falha ao salvar dados do usuário'); // exibe mensagem de erro se falhar ao salvar dados
        await signOut(); // faz logout se falhar ao salvar dados
      }
    } catch (e) {
      showError('Erro', 'Falha ao fazer login'); // exibe mensagem de erro se falhar ao fazer login
    }
  }

  // cria um novo usuario com email, senha e nome
  Future<void> createUser(String email, String password, String name) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ); // cria usuario com email e senha
      User? user = userCredential.user; // obtem o usuario criado
      if (user != null) {
        await firestore.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'profileImage': '',
        }); // salva os dados do usuario no Firestore

        await saveUserDataDB(user.uid); // salva os dados do usuario no banco de dados local
        Get.offAllNamed(Routes.homeView); // redireciona para a tela principal
      }
    } catch (e) {
      showError('Erro', 'Falha ao criar usuário'); // exibe mensagem de erro se falhar ao criar usuario
    }
  }

  // salva os dados do usuario no banco de dados local
  Future<bool> saveUserDataDB(String userId) async {
    try {
      final DocumentSnapshot userDoc = await firestore.doc('users/$userId').get(); // obtem o documento do usuario no Firestore

      await UserDB().saveUserDataDB(
        userDoc['name'],
        userDoc['email'],
        userDoc['profileImage'],
      ); // salva os dados do usuario no banco de dados local
      return true;
    } catch (e) {
      debugPrint('ERROR SAVE USER DB $e'); // imprime mensagem de erro se falhar
      return false;
    }
  }

  // faz logout do usuario
  Future<void> signOut() async {
    await auth.signOut(); // faz logout no FirebaseAuth
    Get.offAllNamed(Routes.loginView); // redireciona para a tela de login
  }

  // exibe uma mensagem de erro
  void showError(String title, String message) {
    AlertTopCommon().error(
      context: Get.context!,
      title: title,
      message: message,
    ); // exibe uma mensagem de erro
  }
}
