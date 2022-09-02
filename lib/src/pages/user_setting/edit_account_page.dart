import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:together_flutter/src/constants/color_constants.dart';
import 'package:together_flutter/src/constants/dimen_constants.dart';
import 'package:together_flutter/src/controllers/user_setting/user_setting_controller.dart';

class EditAccountPage extends GetView<UserSettingController> {
  const EditAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("프로필 편집"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: kHorizontalPadding,
            right: kHorizontalPadding,
            top: kHorizontalPadding),
        child: Column(
          children: [
            Stack(
              children: [
                Obx(
                  () => CircleAvatar(
                    foregroundColor: Colors.transparent,
                    backgroundImage: CachedNetworkImageProvider(
                        controller.user.value.profile!),
                    radius: 50,
                  ),
                ),
                Positioned(
                    right: -10,
                    bottom: -10,
                    child: IconButton(
                        onPressed: () {
                          controller.changeUserProfile();
                        },
                        icon: const Icon(
                          Icons.photo_camera,
                          color: subColor,
                        )))
              ],
            ),
            const SizedBox(
              height: kMiddleSpace,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("프로필 정보"),
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
                            "아이디",
                            style: TextStyle(
                                fontSize: 14, color: Color(0xffc4c4c4)),
                          ),
                          Text(
                            controller.user.value.email,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
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
                        children: const [
                          Text(
                            "비밀번호",
                            style: TextStyle(
                                fontSize: 14, color: Color(0xffc4c4c4)),
                          ),
                          Text(
                            "********",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
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
                        ))
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 50;

    Path path = Path();
    path
      ..moveTo(size.width / 2, size.height)
      ..arcToPoint(Offset(size.width, 0),
          radius: Radius.circular(radius), clockwise: false)
      ..lineTo(0, 0)
      ..arcToPoint(Offset(size.width / 2, size.height),
          radius: Radius.circular(radius), clockwise: false

          // ..moveTo(size.width / 2, 0)
          // ..arcToPoint(Offset(size.width, size.height),
          //     radius: Radius.circular(radius))
          // ..lineTo(0, size.height)
          // ..arcToPoint(
          //   Offset(size.width / 2, 0),
          //   radius: Radius.circular(radius),
          )
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
