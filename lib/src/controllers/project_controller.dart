import 'package:get/get.dart';

class ProjectController extends GetxController {
  static ProjectController get to => Get.find();
  final String projectId = Get.arguments;

  final Rx<int> _index = 0.obs;

  int get currentIndex => _index.value;

  changeIndex(int index) {
    _index(index);
  }
}
