import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:together_flutter/src/constants/color_constants.dart';
import 'package:together_flutter/src/constants/dimen_constants.dart';
import 'package:together_flutter/src/controllers/user_setting/user_setting_controller.dart';

class SettingView extends GetView<UserSettingController> {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("프로필 설정"),
        ),
        body: Obx(() {
          if (controller.user.value.profile != "") {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: kHorizontalPadding,
                        right: kHorizontalPadding,
                        top: kHorizontalPadding),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: CachedNetworkImageProvider(
                              controller.user.value.profile!),
                        ),
                        const Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.user.value.email,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: kSmallSpace,
                            ),
                            OutlinedButton(
                              onPressed: () {
                                Get.toNamed('/EditAccount');
                              },
                              child: const Text("프로필 편집",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                  )),
                            ),
                          ],
                        ),
                        const Spacer(
                          flex: 3,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: kSmallSpace,
                  ),
                  Container(
                    width: double.infinity,
                    height: 4,
                    color: borderColor.withOpacity(0.5),
                  ),
                  const SizedBox(
                    height: kSmallSpace,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kHorizontalPadding),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "이름",
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0xffc4c4c4)),
                                  ),
                                  Text(
                                    controller.user.value.name,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Get.toNamed('/EditUser', parameters: {
                                    "key": "이름",
                                    "value": controller.user.value.name
                                  });
                                },
                                icon: LineIcon(
                                  LineIcons.angleRight,
                                  size: 20,
                                  color: const Color(0xffc4c4c4),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: kSmallSpace,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "휴대전화",
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0xffc4c4c4)),
                                  ),
                                  Text(
                                    controller.user.value.phone,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Get.toNamed('/EditUser', parameters: {
                                    "key": "휴대전화",
                                    "value": controller.user.value.phone
                                  });
                                },
                                icon: LineIcon(
                                  LineIcons.angleRight,
                                  size: 20,
                                  color: const Color(0xffc4c4c4),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: kSmallSpace,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "생년월일",
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0xffc4c4c4)),
                                  ),
                                  Text(
                                    controller.user.value.birth,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Get.toNamed('/EditUser', parameters: {
                                  "key": "생년월일",
                                  "value": controller.user.value.birth
                                });
                              },
                              icon: LineIcon(
                                LineIcons.angleRight,
                                size: 20,
                                color: const Color(0xffc4c4c4),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: kSmallSpace,
                  ),
                  Container(
                    width: double.infinity,
                    height: 4,
                    color: borderColor.withOpacity(0.5),
                  ),
                  const SizedBox(
                    height: kSmallSpace,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kHorizontalPadding),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "로그아웃",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                              },
                              icon: LineIcon(
                                LineIcons.angleRight,
                                size: 20,
                                color: const Color(0xffc4c4c4),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "회원 탈퇴",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: LineIcon(
                                LineIcons.angleRight,
                                size: 20,
                                color: const Color(0xffc4c4c4),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }));
  }
}
