import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:together_flutter/src/constants/api_constants.dart';
import 'package:together_flutter/src/controllers/project_controller.dart';
import 'package:together_flutter/src/models/file.dart';

class FileController extends GetxController {
  static FileController get to => Get.find();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  RxList<ProjectFile> allFiles = RxList([]);
  RxList<Folder> folders = RxList([]);
  RxInt folderIndex = 0.obs;

  RxList<ProjectFile> latestFiles = RxList([]);

  List<String> fileOption = ["다운로드", "삭제"];

  @override
  void onInit() {
    super.onInit();
    getFiles();
    ever(allFiles, (List<ProjectFile> value) {
      classifyFolderType();
      classifyLastest();
    });
  }

  Map<String, double> get folderMap {
    Map<String, double> map = {};

    for (var folder in folders) {
      map.addAll(folder.fileMap);
    }

    return map;
  }

  getFiles() async {
    firestore
        .collection(projectCollection)
        .doc(ProjectController.to.projectId)
        .collection(fileCollection)
        .orderBy('file_date', descending: true)
        .snapshots()
        .listen((event) {
      allFiles.value = event.docs.map((e) => ProjectFile.fromJson(e)).toList();
    });
  }

  downloadFile(ProjectFile file) async {
    var dio = Dio();

    var dir = await getTemporaryDirectory();
    await dio.download(file.downloadUrl, '${dir.path}/${file.title}',
        onReceiveProgress: (rec, total) {
      // print('Rec: $rec, Total: $total');
    });
  }

  deleteFile(ProjectFile file) async {
    final deleteRef = firebaseStorage.refFromURL(file.downloadUrl);
    await deleteRef.delete();

    await firestore
        .collection(projectCollection)
        .doc(ProjectController.to.projectId)
        .collection(fileCollection)
        .doc(file.id)
        .delete();
  }

  void selectFolder(int index) {
    folderIndex(index);
    Get.toNamed('/DetailFolder');
  }

  Folder get currentFolder => folders[folderIndex.value];

  void classifyLastest() {
    if (allFiles.length < 3) {
      latestFiles(allFiles);
    } else {
      latestFiles(allFiles.getRange(0, 3).toList());
    }
  }

  List<Color> get chartColor => [
        Colors.green.withOpacity(0.6),
        Colors.orange.withOpacity(0.6),
        Colors.purple.withOpacity(0.6)
      ];

  void classifyFolderType() {
    folders.value = [
      Folder(
          fileMap: {
            "이미지": allFiles
                .where((p0) => p0.fileType == UploadType.photo)
                .toList()
                .length
                .toDouble()
          },
          color: Colors.green,
          icon: LineIcons.imageFile,
          folderSize: calculateFolderSize(
              allFiles.where((p0) => p0.fileType == UploadType.photo).toList()),
          files:
              allFiles.where((p0) => p0.fileType == UploadType.photo).toList()),
      Folder(
          fileMap: {
            "미디어": allFiles
                .where((p0) => p0.fileType == UploadType.media)
                .toList()
                .length
                .toDouble()
          },
          color: Colors.orange,
          icon: LineIcons.videoFile,
          folderSize: calculateFolderSize(
              allFiles.where((p0) => p0.fileType == UploadType.media).toList()),
          files:
              allFiles.where((p0) => p0.fileType == UploadType.media).toList()),
      Folder(
          fileMap: {
            "문서": allFiles
                .where((p0) => p0.fileType == UploadType.document)
                .toList()
                .length
                .toDouble()
          },
          color: Colors.purple,
          icon: LineIcons.fileInvoice,
          folderSize: calculateFolderSize(allFiles
              .where((p0) => p0.fileType == UploadType.document)
              .toList()),
          files: allFiles
              .where((p0) => p0.fileType == UploadType.document)
              .toList()),
    ];
  }

  double calculateFolderSize(List<ProjectFile> list) {
    double count = 0;
    for (var element in list) {
      count += element.mbSize;
    }
    return count;
  }
}
