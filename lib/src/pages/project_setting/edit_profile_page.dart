import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:together_flutter/src/constants/color_constants.dart';
import 'package:together_flutter/src/constants/dimen_constants.dart';
import 'package:together_flutter/src/controllers/project_setting/edit_project_controller.dart';
import 'package:together_flutter/src/widgets/input_widget.dart';

class EditProjectPage extends GetView<EditProjectController> {
  const EditProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text("프로젝트 ${controller.key} 변경"),
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
              child: Container(
                padding: const EdgeInsets.only(
                    left: kHorizontalPadding,
                    right: kHorizontalPadding,
                    top: kHorizontalPadding),
                child: controller.key != "비밀번호"
                    ? InputWidget(
                        title: "프로젝트 ${controller.key}",
                        textEditingController: controller.text,
                      )
                    : Column(
                        children: [
                          InputWidget(
                            title: "프로젝트 현재 ${controller.key}",
                            textEditingController: controller.text,
                          ),
                          const SizedBox(
                            height: kSmallSpace,
                          ),
                          InputWidget(
                            title: "프로젝트 새 ${controller.key}",
                            textEditingController: controller.passwordText,
                          )
                        ],
                      ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: background,
                  minimumSize: const Size(double.maxFinite, kButtonHeight),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero)),
              onPressed: () {
                controller.editProject();
              },
              child: const Text(
                "변경하기",
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
