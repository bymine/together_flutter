import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:together_flutter/src/constants/api_constants.dart';
import 'package:together_flutter/src/controllers/onboarding/auth_controller.dart';

class EditUserController extends GetxController {
  static EditUserController get to => Get.find();

  TextEditingController text = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  String key = Get.parameters['key'] ?? "";
  String value = Get.parameters['value'] ?? "";
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    text.text = value;
    super.onInit();
  }

  editUser() async {
    Map<String, dynamic> map;
    switch (key) {
      case "이름":
        map = {"name": text.text};
        break;

      case "휴대전화":
        map = {"phone": text.text};
        break;

      case "생년월일":
        map = {"birth": text.text};
        break;

      default:
        map = {};
    }
    await firestore
        .collection(userCollection)
        .doc(AuthController.to.uid)
        .update(map);
    Get.back();
  }
}
