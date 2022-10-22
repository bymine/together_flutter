import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:line_icons/line_icons.dart';
import 'package:together_flutter/src/constants/color_constants.dart';
import 'package:together_flutter/src/constants/dimen_constants.dart';
import 'package:together_flutter/src/controllers/file/add_file_controller.dart';
import 'package:together_flutter/src/models/file.dart';
import 'package:together_flutter/src/widgets/input_widget.dart';

class AddFilePage extends GetView<AddFileController> {
  const AddFilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: const Text("파일 업로드"),
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
                    top: kMiddleSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputWidget(
                      title: "제목",
                      hintText: "파일 제목을 입력하세요",
                      textEditingController: controller.title,
                    ),
                    const SizedBox(
                      height: kLargeSpace,
                    ),
                    Obx(
                      () => InputWidget(
                        title: "첨부 파일",
                        hintText: controller.fileName == ""
                            ? "파일 선택"
                            : controller.fileName,
                        suffix: IconButton(
                            onPressed: () {
                              controller.selectFile();
                            },
                            icon: const Icon(LineIcons.alternateCloudUpload)),
                      ),
                    ),
                    const SizedBox(
                      height: kLargeSpace,
                    ),
                    const Text(
                      "파일 종류",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => GroupButton(
                        options:
                            const GroupButtonOptions(selectedColor: subColor),
                        controller: GroupButtonController(
                          selectedIndex: UploadType.values
                              .indexOf(controller.fileType.value),
                        ),
                        buttons: const ["이미지", "문서", "미디어"],
                        onSelected: (a, b, c) => controller.selectFileExt(b),
                      ),
                    ),
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
                controller.uploadFileToSever();
                Get.back();
              },
              child: const Text(
                "파일 업로드",
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
