import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:together_flutter/src/constants/color_constants.dart';
import 'package:together_flutter/src/constants/dimen_constants.dart';
import 'package:together_flutter/src/controllers/home/show_project_controller.dart';
import 'package:together_flutter/src/widgets/input_widget.dart';

class ShowProjectPage extends GetView<ShowProjectController> {
  const ShowProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    double pageSize = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: pageSize - 60,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: statusBarHeight),
                      width: Get.width,
                      height: Get.width * 0.6,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  controller.currentProject.profile!),
                              fit: BoxFit.fill)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kHorizontalPadding,
                          vertical: kHorizontalPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: kSmallSpace,
                          ),
                          const Text("프로젝트 제목",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(
                            controller.currentProject.title,
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 14, color: dividerColor),
                          ),
                          const SizedBox(
                            height: kLargeSpace,
                          ),
                          const Text("프로젝트 소개글",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(
                            controller.currentProject.note,
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 14, color: dividerColor),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                Get.dialog(
                  AlertDialog(
                    title: const Text('참여코드 입력'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("참여코드 입력이 필요한 프로젝트 입니다"),
                        InputWidget(
                          textEditingController: controller.password,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: const Text("취소"),
                        onPressed: () => Get.back(),
                      ),
                      TextButton(
                        child: const Text("완료"),
                        onPressed: () {
                          controller.joinProject();
                          Get.back();
                        },
                      ),
                    ],
                  ),
                );
              },
              child: Row(
                children: [
                  Text(
                    "(${controller.currentProject.users.length}/${controller.currentProject.maxMember})",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  const Spacer(),
                  const Text(
                    "프로젝트 참여하기",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
