import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:together_flutter/src/constants/api_constants.dart';
import 'package:together_flutter/src/controllers/onboarding/auth_controller.dart';
import 'package:together_flutter/src/controllers/project_controller.dart';
import 'package:together_flutter/src/models/file.dart';

class AddFileController extends GetxController {
  static AddFileController get to => Get.find();
  Rx<File> uploadFile = File("").obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  String get fileName => basename(uploadFile.value.path);
  Rx<UploadType> fileType = UploadType.photo.obs;

  TextEditingController title = TextEditingController();
  void selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      uploadFile.value = File(result.files.single.path!);
    }
  }

  void selectFileExt(int index) {
    switch (index) {
      case 0:
        fileType(UploadType.photo);
        break;
      case 1:
        fileType(UploadType.document);
        break;
      case 2:
        fileType(UploadType.media);
        break;
    }
  }

  void uploadFileToSever() async {
    final ref = firebaseStorage
        .ref("Files")
        .child(ProjectController.to.projectId)
        .child(fileName);

    await ref.putFile(uploadFile.value);
    var fileDownloadUrls = await ref.getDownloadURL();
    int sizeInBytes = uploadFile.value.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);

    var file = ProjectFile(
        title: title.text,
        fileType: fileType.value,
        mbSize: sizeInMb,
        date: Timestamp.fromDate(DateTime.now()),
        writer: AuthController.to.uid,
        downloadUrl: fileDownloadUrls);

    firestore
        .collection(projectCollection)
        .doc(ProjectController.to.projectId)
        .collection(fileCollection)
        .add(file.toMap());
  }
}
