import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:together_flutter/src/constants/api_constants.dart';
import 'package:together_flutter/src/controllers/project_controller.dart';

class EditProjectController extends GetxController {
  static EditProjectController get to => Get.find();

  TextEditingController text = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  String key = Get.parameters['key'] ?? "";
  String value = Get.parameters['value'] ?? "";
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    if (key != "비밀번호") {
      text.text = value;
    }
    super.onInit();
  }

  editProject() async {
    Map<String, dynamic> map;
    switch (key) {
      case "제목":
        map = {"title": text.text};
        break;

      case "소개글":
        map = {"note": text.text};
        break;

      case "최대인원":
        map = {"maxMember": int.parse(text.text)};
        break;

      default:
        if (value == text.text) {
          map = {"maxMember": int.parse(passwordText.text)};
        } else {
          map = {};
        }

        break;
    }
    await firestore
        .collection(projectCollection)
        .doc(ProjectController.to.projectId)
        .update(map);
    Get.back();
  }
}
