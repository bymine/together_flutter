import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:together_flutter/src/constants/api_constants.dart';
import 'package:together_flutter/src/controllers/project_controller.dart';
import 'package:together_flutter/src/models/project.dart';

class ProjectSettingController extends GetxController {
  static ProjectSettingController get to => Get.find();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  Rx<Project> project = Project(title: "", note: "", users: []).obs;
  @override
  void onInit() {
    super.onInit();
    loadProjectData();
  }

  loadProjectData() {
    firestore
        .collection(projectCollection)
        .doc(ProjectController.to.projectId)
        .snapshots()
        .listen((event) {
      project(Project.fromJson(event));
    });
  }

  changeProjectProfile() async {
    final imagePicker = ImagePicker();

    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final ref = firebaseStorage
          .ref("Background")
          .child(ProjectController.to.projectId);

      await ref.putFile(File(pickedFile.path));
      var fileDownloadUrls = await ref.getDownloadURL();

      await firestore
          .collection(projectCollection)
          .doc(project.value.id)
          .update({"profile": fileDownloadUrls});
    }
  }
}
