import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:together_flutter/src/constants/color_constants.dart';
import 'package:together_flutter/src/constants/dimen_constants.dart';
import 'package:together_flutter/src/controllers/project_setting/project_setting_controller.dart';

class ProjectSettingView extends GetView<ProjectSettingController> {
  const ProjectSettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("프로젝트 설정"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(
                top: kHorizontalPadding,
                left: kHorizontalPadding,
                right: kHorizontalPadding),
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "프로젝트 프로필",
                          style: TextStyle(fontSize: 14, color: dividerColor),
                        ),
                        InkWell(
                          onTap: () {
                            controller.changeProjectProfile();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: subColor)),
                            child: const Text(
                              "편집 하기",
                              style: TextStyle(fontSize: 10, color: subColor),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => AspectRatio(
                        aspectRatio: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    controller.project.value.profile!),
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: kMiddleSpace,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "프로젝트 제목",
                            style: TextStyle(
                              fontSize: 14,
                              color: dividerColor,
                            ),
                          ),
                          Obx(
                            () => Text(
                              controller.project.value.title,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Get.toNamed('/EditProject', parameters: {
                            "key": "제목",
                            "value": controller.project.value.title
                          });
                        },
                        icon: LineIcon(
                          LineIcons.angleRight,
                          size: 20,
                          color: dividerColor,
                        ))
                  ],
                ),
                const SizedBox(
                  height: kMiddleSpace,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "프로젝트 소개글",
                            style: TextStyle(
                              fontSize: 14,
                              color: dividerColor,
                            ),
                          ),
                          Obx(
                            () => Text(
                              controller.project.value.note,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Get.toNamed('/EditProject', parameters: {
                            "key": "소개글",
                            "value": controller.project.value.note
                          });
                        },
                        icon: LineIcon(
                          LineIcons.angleRight,
                          size: 20,
                          color: dividerColor,
                        ))
                  ],
                ),
                const SizedBox(
                  height: kMiddleSpace,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "비밀번호",
                            style: TextStyle(
                              fontSize: 14,
                              color: dividerColor,
                            ),
                          ),
                          Text(
                            "******",
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Get.toNamed('/EditProject',
                              parameters: {"key": "비밀번호", "value": "******"});
                        },
                        icon: LineIcon(
                          LineIcons.angleRight,
                          size: 20,
                          color: dividerColor,
                        ))
                  ],
                ),
                const SizedBox(
                  height: kMiddleSpace,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "프로젝트 최대인원",
                            style: TextStyle(
                              fontSize: 14,
                              color: dividerColor,
                            ),
                          ),
                          Obx(
                            () => Text(
                              controller.project.value.maxMember.toString(),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Get.toNamed('/EditProject', parameters: {
                            "key": "최대인원",
                            "value":
                                controller.project.value.maxMember.toString()
                          });
                        },
                        icon: LineIcon(
                          LineIcons.angleRight,
                          size: 20,
                          color: dividerColor,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
