import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:together_flutter/src/constants/color_constants.dart';
import 'package:together_flutter/src/constants/dimen_constants.dart';
import 'package:together_flutter/src/controllers/onboarding/auth_controller.dart';
import 'package:together_flutter/src/controllers/schedule/schedule_controller.dart';
import 'package:together_flutter/src/models/schedule.dart';
import 'package:together_flutter/src/utils.dart';

class ScheduleView extends GetView<ScheduleController> {
  const ScheduleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("프로젝트 일정"),
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed('AddSchedule', arguments: controller.selectedDay);
                },
                icon: LineIcon(LineIcons.calendarPlus))
          ],
        ),
        body: Obx(() {
          if (controller.classfiyCondition.value) {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(
                  top: kHorizontalPadding,
                  left: kHorizontalPadding,
                  right: kHorizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => TableCalendar<Schedule>(
                      locale: 'ko-KR',
                      daysOfWeekHeight: 30,
                      focusedDay: controller.focusedDay.value,
                      calendarStyle: CalendarStyle(
                        markersMaxCount: 1,
                        selectedDecoration: BoxDecoration(
                            color: subColor.withOpacity(0.5),
                            shape: BoxShape.circle),
                      ),
                      firstDay: DateTime(2021),
                      lastDay: DateTime(2023),
                      headerVisible: false,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      selectedDayPredicate: (day) =>
                          isSameDay(controller.selectedDay.value, day),
                      onDaySelected: controller.onDaySelected,
                      eventLoader: controller.initalEventLoader,
                    ),
                  ),
                  const DateLine(),
                  const SizedBox(
                    height: kSmallSpace,
                  ),
                  controller.selectedSchedule.isNotEmpty
                      ? const ScheduleViewer()
                      : Container()
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }));
  }
}

class DateLine extends GetView<ScheduleController> {
  const DateLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(left: 16, top: 20),
        child: RichText(
          text: TextSpan(
            text: DateFormat('d, ').format(controller.selectedDay.value!),
            style: const TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: DateFormat('EEE', 'ko')
                    .format(controller.selectedDay.value!),
                style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                    fontSize: 16),
              ),
              TextSpan(
                text: controller.selectedSchedule.isEmpty
                    ? "     일정 없음"
                    : "     일정 ${controller.selectedSchedule.length}개",
                style: const TextStyle(color: dividerColor, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScheduleViewer extends GetView<ScheduleController> {
  const ScheduleViewer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Row(
            children: [
              Text(
                DateFormat("hh:mm a").format(
                    controller.selectedSchedule.first.startTime.toDate()),
                style: const TextStyle(color: dividerColor),
              ),
              const SizedBox(
                width: kSmallSpace,
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: borderColor,
                ),
              )
            ],
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.selectedSchedule.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(left: 60, bottom: 10, top: 10),
                decoration: const BoxDecoration(
                    color: Color(0xffF0EDFF),
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    // leading: CircleAvatar(
                    //   backgroundImage: CachedNetworkImageProvider(
                    //       controller.selectedSchedule[index].writer),
                    // ),
                    title: Text(
                      Utils.formatScheduleTime(
                          controller.selectedSchedule[index].startTime.toDate(),
                          controller.selectedSchedule[index].endTime.toDate()),
                      style: const TextStyle(color: subColor, fontSize: 14),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.selectedSchedule[index].title,
                          style: const TextStyle(
                              color: subColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          controller.selectedSchedule[index].note,
                          style: const TextStyle(color: subColor, fontSize: 16),
                        ),
                      ],
                    ),
                    trailing: controller.selectedSchedule[index].writer ==
                            AuthController.to.uid
                        ? DropdownButton(
                            underline: Container(),
                            icon: const Icon(Icons.settings),
                            iconSize: 20,
                            iconEnabledColor: subColor,
                            items: ['삭제']
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              controller.selectScheduleOption(value.toString(),
                                  controller.selectedSchedule[index]);
                            })
                        : const SizedBox(
                            width: 1,
                          )),
              );
            },
          ),
          Row(
            children: [
              Text(
                DateFormat("hh:mm a")
                    .format(controller.selectedSchedule.last.endTime.toDate()),
                style: const TextStyle(color: dividerColor),
              ),
              const SizedBox(
                width: kSmallSpace,
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: borderColor,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
