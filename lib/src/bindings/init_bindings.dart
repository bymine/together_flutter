import 'package:get/get.dart';
import 'package:together_flutter/src/controllers/onboarding/auth_controller.dart';

class InitBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
