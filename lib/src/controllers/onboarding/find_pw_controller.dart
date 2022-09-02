import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindPwController extends GetxController {
  //Variables FindPassword
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController birth = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController code = TextEditingController();

  RxBool phoneAuth = false.obs;
}
