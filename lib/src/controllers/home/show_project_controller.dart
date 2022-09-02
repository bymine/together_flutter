import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:together_flutter/src/constants/api_constants.dart';
import 'package:together_flutter/src/controllers/home/home_controller.dart';
import 'package:together_flutter/src/controllers/onboarding/auth_controller.dart';
import 'package:together_flutter/src/models/project.dart';

class ShowProjectController extends GetxController {
  static ShowProjectController get to => Get.find();

  TextEditingController password = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Project currentProject = Get.arguments;

  @override
  void onClose() {
    HomeController.to.loadProjects();
    super.onClose();
  }

  void joinProject() async {
    currentProject.users.add({"user": AuthController.to.uid, "active": false});
    if (currentProject.password == password.text) {
      firestore
          .collection(projectCollection)
          .doc(currentProject.id)
          .update(currentProject.toMap());
    }
  }
}
