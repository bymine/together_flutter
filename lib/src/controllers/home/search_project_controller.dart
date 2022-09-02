import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:together_flutter/src/constants/api_constants.dart';
import 'package:together_flutter/src/controllers/onboarding/auth_controller.dart';
import 'package:together_flutter/src/models/project.dart';

class SearchProjectController extends GetxController {
  static SearchProjectController get to => Get.find();

  RxList<Project> projects = RxList([]);
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Rx<FirebaseCode> firebaseCode = FirebaseCode.init.obs;
  @override
  void onInit() {
    super.onInit();
    loadSerchProjects();
  }

  loadSerchProjects() async {
    firebaseCode(FirebaseCode.loading);
    try {
      var data = await firestore
          .collection(projectCollection)
          .where("user", whereNotIn: [
        {"active": false, "user": AuthController.to.uid}
      ]).get();
      projects(data.docs.map((e) => Project.fromQuerySnapshot(e)).toList());
      firebaseCode(FirebaseCode.success);
    } catch (e) {
      firebaseCode(FirebaseCode.failed);
    }
  }
}
