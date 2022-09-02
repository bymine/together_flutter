import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:together_flutter/src/constants/api_constants.dart';
import 'package:together_flutter/src/models/user.dart';
import 'package:together_flutter/src/widgets/alert_message.dart';

class SignUpController extends GetxController {
  static SignUpController get to => Get.find();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rePassword = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController birth = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController code = TextEditingController();

  FocusNode passwordFocusNode = FocusNode();
  FocusNode rePasswordFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  FocusNode birthFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode codeNode = FocusNode();

  RxBool allAgree = false.obs;
  RxBool useAgree = false.obs;
  RxBool infoAgree = false.obs;
  RxBool ageAgree = false.obs;

  RxBool phoneAuth = false.obs;

  RxString verificationId = "".obs;
  RxString smsCode = "".obs;

  bool get activeSignUp {
    if (allAgree.value ||
        (useAgree.value && infoAgree.value && ageAgree.value)) {
      return true;
    } else {
      return false;
    }
  }

  void agreeCheck(String type) {
    switch (type) {
      case "use":
        useAgree.value = !useAgree.value;
        break;
      case "info":
        infoAgree.value = !infoAgree.value;
        break;

      case "age":
        ageAgree.value = !ageAgree.value;
        break;

      case "all":
        allAgree.value = !allAgree.value;
        useAgree.value = allAgree.value;
        infoAgree.value = allAgree.value;
        ageAgree.value = allAgree.value;
        break;
    }
  }

  void requestSms() async {
    await auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
      phoneNumber: "+82${phone.text.substring(1)}",
      verificationCompleted: (phoneAuthCredential) {
        smsCode(phoneAuthCredential.smsCode);
        smsCode.refresh();
      },
      verificationFailed: (verificationFailed) {},
      codeSent: (verificationId, resendingToken) {
        Get.dialog(const AlertMessage(
          message: "SMS 인증 코드가 발송되었습니다.",
        ));
        phoneAuth(true);
        this.verificationId(verificationId);
      },
    );
  }

  void signInWithPhone() async {
    if (smsCode.value == code.text) {
      Get.dialog(const AlertMessage(
        message: "SMS 인증이 완료 되었습니다",
      ));
    } else {
      Get.dialog(const AlertMessage(
        message: "SMS 인증 번호가 올바르지 않습니다",
      ));
    }
  }

  signUpUserCredential() async {
    if (formKey.currentState!.validate()) {
      UserCredential? userCredential;

      try {
        userCredential = await auth.createUserWithEmailAndPassword(
            email: email.text.trim(), password: password.text.trim());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
        } else if (e.code == 'email-already-in-use') {
          Get.dialog(const AlertMessage(
            message: "사용중인 이메일 입니다.",
          ));
        }
        userCredential == null;
      }

      if (userCredential != null) {
        TogetherUser user = TogetherUser(
            uid: userCredential.user!.uid,
            name: name.text,
            email: email.text,
            phone: phone.text,
            birth: birth.text);
        firestore
            .collection(userCollection)
            .doc(userCredential.user!.uid)
            .set(user.toMap());
      }
    }
  }
}
