import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:together_flutter/src/constants/api_constants.dart';
import 'package:together_flutter/src/controllers/onboarding/auth_controller.dart';
import 'package:together_flutter/src/models/project.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  RxList<Project> projects = RxList([]);
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Rx<FirebaseCode> firebaseCode = FirebaseCode.init.obs;
  @override
  void onInit() {
    super.onInit();
    loadProjects();
  }

  loadProjects() async {
    firebaseCode(FirebaseCode.loading);

    try {
      firestore
          .collection(projectCollection)
          .where("user", arrayContainsAny: [
            {"active": false, "user": AuthController.to.uid},
            {"active": true, "user": AuthController.to.uid}
          ])
          .snapshots()
          .listen((event) {
            projects(
                event.docs.map((e) => Project.fromQuerySnapshot(e)).toList());
          });

      firebaseCode(FirebaseCode.success);
    } catch (e) {
      firebaseCode(FirebaseCode.failed);
    }
  }
}
