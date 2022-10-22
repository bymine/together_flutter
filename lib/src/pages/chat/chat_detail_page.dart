import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:together_flutter/src/constants/api_constants.dart';
import 'package:together_flutter/src/constants/color_constants.dart';
import 'package:together_flutter/src/constants/dimen_constants.dart';
import 'package:together_flutter/src/controllers/chat/chat_detail_controller.dart';
import 'package:together_flutter/src/controllers/onboarding/auth_controller.dart';

class ChatDetailPage extends GetView<ChatDetailController> {
  const ChatDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
        title: const Text("채팅 디테일"),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 40),
          child: Obx(
            () => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: List.generate(
                          controller.chatUsers.length,
                          (index) => controller.chatUsers[index].active
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                          radius: 20,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                            controller.chatUsers[index].profile,
                                          )),
                                      const Positioned(
                                          right: 0,
                                          top: 0,
                                          child: CircleAvatar(
                                              radius: 6,
                                              backgroundColor: Colors.red))
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: CircleAvatar(
                                      radius: 20,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        controller.chatUsers[index].profile,
                                      )),
                                ))),
                )),
          ),
        ));
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.firebaseCode.value == FirebaseCode.success) {
                return ListView.builder(
                    controller: controller.scrollController,
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: controller.loadMessage.length,
                    itemBuilder: (context, index) {
                      return MessageCard(
                        index: index,
                      );
                    });
              } else {
                return Container();
              }
            }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: kButtonHeight,
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: TextField(
                controller: controller.message,
                maxLines: null,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffF0EDFF),
                    hintText: "메세지를 입력하세요",
                    hintStyle: const TextStyle(fontSize: 14),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                        borderSide: BorderSide.none),
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.sendMessage();
                        },
                        icon: LineIcon(LineIcons.paperPlane))),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MessageCard extends GetView<ChatDetailController> {
  const MessageCard({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        horizontalTitleGap: 20,
        contentPadding: const EdgeInsets.all(10),
        leading: controller.loadMessage[index].writer == AuthController.to.uid
            ? null
            : Column(
                children: [
                  Obx(
                    () => CircleAvatar(
                      radius: 16,
                      backgroundImage: CachedNetworkImageProvider(
                        controller.chatUsers
                            .firstWhere((element) =>
                                element.uid ==
                                controller.loadMessage[index].writer)
                            .profile,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Obx(() => Text(
                        controller.chatUsers
                            .firstWhere((element) =>
                                element.uid ==
                                controller.loadMessage[index].writer)
                            .name,
                        style: const TextStyle(fontSize: 12),
                      ))
                ],
              ),
        title: controller.loadMessage[index].writer == AuthController.to.uid
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: Get.width * 0.5,
                    ),
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xffF0EDFF),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: Text(controller.loadMessage[index].title),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    DateFormat('hh:mm')
                        .format(controller.loadMessage[index].date.toDate()),
                    style: const TextStyle(fontSize: 12, color: dividerColor),
                  )
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: Get.width * 0.5,
                    ),
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xffC4C4C4),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Text(controller.loadMessage[index].title),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    DateFormat('hh:mm')
                        .format(controller.loadMessage[index].date.toDate()),
                    style: const TextStyle(fontSize: 12, color: dividerColor),
                  )
                ],
              ));
  }
}
