import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:together_flutter/src/constants/color_constants.dart';
import 'package:together_flutter/src/constants/dimen_constants.dart';
import 'package:together_flutter/src/controllers/home/add_project_controller.dart';
import 'package:together_flutter/src/widgets/input_widget.dart';

class AddProjectPage extends GetView<AddProjectController> {
  const AddProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: const Text("프로젝트 생성"),
    );
    double pageSize = MediaQuery.of(context).size.height;
    double notifySize = MediaQuery.of(context).padding.top;
    double appBarSize = appBar.preferredSize.height;
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: pageSize - (notifySize + appBarSize + 60),
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: kHorizontalPadding,
                              left: kHorizontalPadding,
                              right: kHorizontalPadding),
                          child: Column(
                            children: [
                              InputWidget(
                                title: "제목",
                                hintText: "프로젝트 제목을 입력하세요.",
                                textEditingController: controller.title,
                                validator: (title) {
                                  if (title!.isEmpty) {
                                    return "제목을 입력하세요";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: kMiddleSpace,
                              ),
                              InputWidget(
                                title: "소개글",
                                hintText: "프로젝트 소개글을 입력하세요.",
                                textEditingController: controller.note,
                                validator: (note) {
                                  if (note!.isEmpty) {
                                    return "제목을 입력하세요";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: kMiddleSpace,
                              ),
                              Obx(
                                () => Visibility(
                                  visible: controller.activePassword.value,
                                  child: InputWidget(
                                    title: "비밀번호",
                                    hintText: "프로젝트 비밀번호를 입력하세요.",
                                    textEditingController: controller.password,
                                    validator: (password) {
                                      if (password!.isEmpty) {
                                        return "제목을 입력하세요";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: kMiddleSpace,
                              ),
                              Obx(
                                () => Visibility(
                                  visible: controller.activeMaxMember.value,
                                  child: InputWidget(
                                    title: "인원 제한",
                                    hintText: "최대 인원 수를 입력하세요.",
                                    textEditingController: controller.maxMember,
                                    validator: (maxMember) {
                                      if (maxMember!.isEmpty) {
                                        return "제목을 입력하세요";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: kMiddleSpace,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 4,
                          color: borderColor.withOpacity(0.5),
                        ),
                        Obx(
                          () => SwitchListTile(
                            activeColor: subColor,
                            value: controller.activePassword.value,
                            onChanged: (value) {
                              controller.switchSetting(value, "Password");
                            },
                            title: const Text("비밀번호 설정",
                                style: TextStyle(fontSize: 12)),
                          ),
                        ),
                        Obx(
                          () => SwitchListTile(
                            activeColor: subColor,
                            value: controller.activeMaxMember.value,
                            onChanged: (value) {
                              controller.switchSetting(value, "Member");
                            },
                            title: const Text("인원제한 설정",
                                style: TextStyle(fontSize: 12)),
                          ),
                        ),
                      ],
                    ),
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
                controller.addProject();
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
    );
  }
}
