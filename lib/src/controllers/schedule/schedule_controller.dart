import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:together_flutter/src/constants/api_constants.dart';
import 'package:together_flutter/src/controllers/project_controller.dart';
import 'package:together_flutter/src/models/schedule.dart';
import 'package:together_flutter/src/utils.dart';

enum ApiStatus {
  success,
  loading,
  failed,
  init,
}

class ScheduleController extends GetxController {
  static ScheduleController get to => Get.find();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final RxList<Schedule> _loadschedules = RxList([]);

  final _scheduleMap = LinkedHashMap<DateTime, List<Schedule>>(
          equals: isSameDay, hashCode: Utils.getHashCode)
      .obs;
  final Rx<DateTime> focusedDay = DateTime.now().obs;
  late Rx<DateTime?> selectedDay;
  RxList<Schedule> selectedSchedule = RxList([]);
  Rx<ApiStatus> apistatus = ApiStatus.init.obs;
  Rx<bool> classfiyCondition = false.obs;

  @override
  void onInit() {
    selectedDay = focusedDay;
    getAllSchedule();
    ever(_loadschedules, (List<Schedule> value) {
      classifyScheduleEvent();
      getEventsForDay(focusedDay.value);
    });
    super.onInit();
  }

  void getAllSchedule() async {
    try {
      firestore
          .collection(projectCollection)
          .doc(ProjectController.to.projectId)
          .collection(scheduleCollection)
          .snapshots()
          .listen((event) {
        _loadschedules(event.docs.map((e) => Schedule.fromJson(e)).toList());
      });
    } catch (e) {
      _loadschedules([]);
    }
  }

  void classifyScheduleEvent() {
    _scheduleMap.value.clear();
    classfiyCondition(false);
    for (var schedule in _loadschedules) {
      List<Schedule> list =
          _scheduleMap.value[schedule.startTime.toDate()] ?? [];
      list.add(schedule);
      _scheduleMap.value[schedule.startTime.toDate()] = list;
    }
    _scheduleMap.refresh();
    classfiyCondition(true);
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(this.selectedDay.value, selectedDay)) {
      this.selectedDay.value = selectedDay;
      this.focusedDay.value = focusedDay;
    }
    getEventsForDay(this.focusedDay.value);
  }

  List<Schedule> getEventsForDay(DateTime day) {
    selectedSchedule.value = _scheduleMap.value[day] ?? [];
    selectedSchedule.sort((a, b) => a.startTime.compareTo(b.startTime));
    selectedSchedule.refresh();
    return selectedSchedule;
  }

  List<Schedule> initalEventLoader(DateTime day) {
    return _scheduleMap.value[day] ?? [];
  }

  void selectScheduleOption(String value, Schedule schedule) {
    firestore
        .collection(projectCollection)
        .doc(ProjectController.to.projectId)
        .collection("Schedule")
        .doc(schedule.id)
        .delete();
  }
}
