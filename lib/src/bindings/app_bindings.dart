import 'package:get/get.dart';
import 'package:together_flutter/src/controllers/app_controller.dart';
import 'package:together_flutter/src/controllers/chat/chat_controller.dart';
import 'package:together_flutter/src/controllers/home/home_controller.dart';
import 'package:together_flutter/src/controllers/user_setting/user_setting_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AppController());
    Get.put(HomeController());
    Get.lazyPut(() => ChatController());
    Get.lazyPut(() => UserSettingController());
  }
}
