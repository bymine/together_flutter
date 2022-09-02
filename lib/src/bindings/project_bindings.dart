import 'package:get/get.dart';
import 'package:together_flutter/src/controllers/file/file_controller.dart';
import 'package:together_flutter/src/controllers/project_controller.dart';
import 'package:together_flutter/src/controllers/project_setting/project_setting_controller.dart';
import 'package:together_flutter/src/controllers/schedule/schedule_controller.dart';

class ProjectBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ProjectController());
    Get.put(ScheduleController());
    Get.put(FileController());
    Get.put(ProjectSettingController());
  }
}
