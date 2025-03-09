import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:quiz_portugues/app/ui/widgets/common/alert/alert_top_common.dart';

import '../../data/database/user_db.dart';
import '../../routes/routes.dart';

class AuthService extends GetxController {
  Rx<User?> _user = Rx<User?>(FirebaseAuth.instance.currentUser);

  User? get user => _user.value;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, checkLogin);
  }

  checkLogin(User? user) {
    if (user == null && _user.value != null) {
      Get.offAllNamed(Routes.loginView);
    } else if (user != null) {
      Get.offNamed(Routes.homeView);
    }
  }

  Future<void> loginUser(String user, String password) async {
    try {
      UserCredential userId = await auth.signInWithEmailAndPassword(
          email: user, password: password);

      var isLogin = await saveUserDataDB(userId.user!.uid);
      if (isLogin) {
        Get.offAllNamed(Routes.homeView);
      } else {
        AlertTopCommon().error(
          context: Get.context!,
          title: 'Erro',
          message: 'Falha ao salvar dados do usuário',
        );
        await signOut();
      }
    } catch (e) {
      AlertTopCommon().error(
        context: Get.context!,
        title: 'Erro',
        message: 'Falha ao fazer login',
      );
    }
  }

  Future<void> createUser(String email, String password, String name) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await firestore.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'profileImage': '',
        });

        await saveUserDataDB(user.uid);
        Get.offAllNamed(Routes.homeView);
      }
    } catch (e) {
      // NotificationTop().createError();
      AlertTopCommon().error(
        context: Get.context!,
        title: 'Erro',
        message: 'Falha ao criar usuário',
      );
    }
  }

  Future<bool> saveUserDataDB(userId) async {
    try {
      final DocumentSnapshot user = await firestore.doc('users/$userId').get();

      await UserDB().saveUserDataDB(
        user['name'],
        user['email'],
        user['profileImage'],
      );
      return true;
    } catch (e) {
      print('ERROR SAVE USER DB $e');
      return false;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await auth.signOut();

    Get.offAllNamed(Routes.loginView);
  }
}
