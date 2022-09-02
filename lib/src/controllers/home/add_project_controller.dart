import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:together_flutter/src/constants/api_constants.dart';
import 'package:together_flutter/src/controllers/home/home_controller.dart';
import 'package:together_flutter/src/controllers/onboarding/auth_controller.dart';
import 'package:together_flutter/src/models/project.dart';

class AddProjectController extends GetxController {
  static AddProjectController get to => Get.find();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController maxMember = TextEditingController();

  RxBool activePassword = true.obs;
  RxBool activeMaxMember = true.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onClose() {
    HomeController.to.loadProjects();
    super.onClose();
  }

  switchSetting(bool value, String type) {
    switch (type) {
      case "Password":
        activePassword(value);
        break;
      case "Member":
        activeMaxMember(value);
        break;
    }
  }

  addProject() async {
    Project project = Project(
        title: title.text,
        note: note.text,
        password: password.text,
        users: [
          {"user": AuthController.to.uid, "active": false}
        ],
        maxMember: int.parse(maxMember.text));
    firestore.collection(projectCollection).doc().set(project.toMap());
  }
}
