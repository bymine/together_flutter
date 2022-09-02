import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:together_flutter/src/constants/api_constants.dart';
import 'package:together_flutter/src/controllers/onboarding/auth_controller.dart';
import 'package:together_flutter/src/models/user.dart';

class UserSettingController extends GetxController {
  static UserSettingController get to => Get.find();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  Rx<TogetherUser> user = TogetherUser(
          uid: "", name: "", email: "", phone: "", birth: "", profile: "")
      .obs;
  @override
  void onInit() {
    loadUser();
    super.onInit();
  }

  loadUser() {
    firestore
        .collection("User")
        .doc(AuthController.to.uid)
        .snapshots()
        .listen((event) {
      user(TogetherUser.fromJson(event));
    });
  }

  changeUserProfile() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final ref = firebaseStorage.ref("Profile").child(AuthController.to.uid);

      await ref.putFile(File(pickedFile.path));
      var fileDownloadUrls = await ref.getDownloadURL();

      await firestore
          .collection(userCollection)
          .doc(AuthController.to.uid)
          .update({'profile': fileDownloadUrls});
    }
  }
}
