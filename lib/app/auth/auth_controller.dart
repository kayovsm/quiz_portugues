import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/database/user_data.dart';
import '../routes/routes_mobile.dart';
import '../widgets/notification.dart';

class AuthControllerMobile extends GetxController {
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
      Get.offAllNamed(RoutesMobile.loginPage);
    } else if (user != null) {
      Get.offNamed(RoutesMobile.homePage);
    }
  }

  Future<void> loginUser(String user, String password) async {
    try {
      UserCredential userId = await auth.signInWithEmailAndPassword(
          email: user, password: password);

      var isLogin = await saveUserDataDB(userId.user!.uid);
      if (isLogin) {
        Get.offAllNamed(RoutesMobile.homePage);
      } else {
        NotificationTop().loginError();
        await signOut();
      }
    } catch (e) {
      NotificationTop().loginError();
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
        Get.offAllNamed(RoutesMobile.homePage);
      }
    } catch (e) {
      NotificationTop().loginError();
    }
  }

  Future<bool> saveUserDataDB(userId) async {
    try {
      final DocumentSnapshot user = await firestore.doc('users/$userId').get();

      await UserDataDB().saveUserDataDB(
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

    Get.offAllNamed(RoutesMobile.loginPage);
  }
}
