import 'package:get/get.dart';
import 'package:together_flutter/src/controllers/file/file_controller.dart';
import 'package:together_flutter/src/models/file.dart';

class DetailFolderController extends GetxController {
  static DetailFolderController get to => Get.find();

  late Rx<Folder> currentFolder;

  @override
  void onInit() {
    currentFolder = FileController.to.currentFolder.obs;

    FileController.to.folders.listen((p0) {
      currentFolder(FileController.to.currentFolder);
    });
    super.onInit();
  }
}
