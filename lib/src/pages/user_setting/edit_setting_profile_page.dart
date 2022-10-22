import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:together_flutter/src/constants/color_constants.dart';
import 'package:together_flutter/src/constants/dimen_constants.dart';
import 'package:together_flutter/src/controllers/user_setting/edit_user_controller.dart';
import 'package:together_flutter/src/widgets/input_widget.dart';

class EditSettingUserProfilePage extends GetView<EditUserController> {
  const EditSettingUserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text("${controller.key} 변경"),
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
                child: InputWidget(
                  title: controller.key,
                  textEditingController: controller.text,
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
                controller.editUser();
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
