import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:together_flutter/src/widgets/alert_message.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  String get uid => _user.value!.uid;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initalScreen);
  }

  _initalScreen(User? user) async {
    if (user == null) {
      Get.offAllNamed('/SignIn');
    } else {
      Get.offAllNamed('/App');
    }
  }

  signIn() async {
    if (formKey.currentState!.validate()) {
      try {
        await auth.signInWithEmailAndPassword(
            email: email.text, password: password.text);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.dialog(const AlertMessage(message: "존재하지 않는 계정입니다."));
        } else if (e.code == 'wrong-password') {
          Get.dialog(const AlertMessage(message: "비밀번호가 올바르지 않습니다"));
        }
      }
    }
  }
}
