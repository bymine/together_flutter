import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:together_flutter/src/constants/api_constants.dart';
import 'package:together_flutter/src/controllers/onboarding/auth_controller.dart';
import 'package:together_flutter/src/controllers/project_controller.dart';
import 'package:together_flutter/src/models/schedule.dart';

class AddScheduleController extends GetxController {
  static AddScheduleController get to => Get.find();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<DateTime> startDate = Get.arguments;
  Rx<DateTime> endDate = Get.arguments;

  void addSchedule() {
    if (formKey.currentState!.validate()) {
      var schedule = Schedule(
          title: title.text,
          note: note.text,
          startTime: Timestamp.fromDate(startDate.value),
          endTime: Timestamp.fromDate(endDate.value),
          writer: AuthController.to.uid);

      firestore
          .collection(projectCollection)
          .doc(ProjectController.to.projectId)
          .collection(scheduleCollection)
          .add(schedule.toMap());

      Get.back();
    }
  }

  Future<void> selectDate(
      {required bool isDate, required bool? isStart}) async {
    if (isDate) {
      DateTime? pickerDate = await showDatePicker(
          context: Get.context!,
          initialDate: startDate.value,
          firstDate: DateTime(2020),
          lastDate: DateTime(2024));

      if (pickerDate != null) {
        startDate.value =
            DateTime(pickerDate.year, pickerDate.month, pickerDate.day);
        endDate.value =
            DateTime(pickerDate.year, pickerDate.month, pickerDate.day);
      }
    } else {
      TimeOfDay? pcikerTime = await showTimePicker(
          context: Get.context!,
          initialTime: isStart!
              ? TimeOfDay.fromDateTime(startDate.value)
              : TimeOfDay.fromDateTime(endDate.value));
      if (pcikerTime != null) {
        if (isStart) {
          startDate.value = DateTime(
              startDate.value.year,
              startDate.value.month,
              startDate.value.day,
              pcikerTime.hour,
              pcikerTime.minute);
        } else {
          endDate.value = DateTime(endDate.value.year, endDate.value.month,
              endDate.value.day, pcikerTime.hour, pcikerTime.minute);
        }
      }
    }
  }
}
