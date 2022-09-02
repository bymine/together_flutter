import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindIdController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController birth = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController code = TextEditingController();

  RxBool phoneAuth = false.obs;
}
