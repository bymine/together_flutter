import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:together_flutter/src/constants/color_constants.dart';
import 'package:together_flutter/src/constants/dimen_constants.dart';
import 'package:together_flutter/src/controllers/schedule/add_schedule_controller.dart';
import 'package:together_flutter/src/utils.dart';
import 'package:together_flutter/src/widgets/input_widget.dart';

class AddSchedulePage extends GetView<AddScheduleController> {
  const AddSchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: const Text("프로젝트 생성"),
    );
    double pageSize = MediaQuery.of(context).size.height;
    double notifySize = MediaQuery.of(context).padding.top;
    double appBarSize = appBar.preferredSize.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("일정 생성"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              SizedBox(
                height: pageSize - (notifySize + appBarSize + 60),
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: kHorizontalPadding,
                        right: kHorizontalPadding,
                        top: kHorizontalPadding),
                    child: Column(
                      children: [
                        InputWidget(
                          textEditingController: controller.title,
                          title: "일정 제목",
                          hintText: "일정 제목을 입력하세요.",
                          validator: (title) {
                            if (title!.isEmpty) {
                              return "제목을 입력하세요.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: kMiddleSpace,
                        ),
                        InputWidget(
                          textEditingController: controller.note,
                          title: "일정 메모",
                          hintText: "일정 메모를 입력하세요.",
                          validator: (note) {
                            if (note!.isEmpty) {
                              return "제목을 입력하세요.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: kMiddleSpace,
                        ),
                        Obx(
                          () => InputWidget(
                            title: "날짜",
                            hintText: Utils.formatDate(
                                controller.startDate.value, "/"),
                            readOnly: true,
                            button: InkWell(
                              onTap: () {
                                controller.selectDate(
                                    isDate: true, isStart: null);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: subColor)),
                                child: const Text(
                                  "날짜 선택",
                                  style:
                                      TextStyle(fontSize: 10, color: subColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: kMiddleSpace,
                        ),
                        Obx(
                          () => Row(
                            children: [
                              Expanded(
                                  child: InputWidget(
                                title: "시작 시간",
                                hintText: Utils.formatTime(
                                    controller.startDate.value),
                                readOnly: true,
                                button: InkWell(
                                  onTap: () {
                                    controller.selectDate(
                                        isDate: false, isStart: true);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(color: subColor)),
                                    child: const Text(
                                      "시간 선택",
                                      style: TextStyle(
                                          fontSize: 10, color: subColor),
                                    ),
                                  ),
                                ),
                              )),
                              const SizedBox(
                                width: kMiddleSpace,
                              ),
                              Expanded(
                                  child: InputWidget(
                                title: "종료 시간",
                                hintText: Utils.formatTime(
                                    controller.startDate.value),
                                readOnly: true,
                                button: InkWell(
                                  onTap: () {
                                    controller.selectDate(
                                        isDate: false, isStart: false);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(color: subColor)),
                                    child: const Text(
                                      "시간 선택",
                                      style: TextStyle(
                                          fontSize: 10, color: subColor),
                                    ),
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: background,
                    minimumSize: const Size(double.maxFinite, kButtonHeight),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero)),
                onPressed: () {
                  controller.addSchedule();
                },
                child: const Text(
                  "생성하기",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
