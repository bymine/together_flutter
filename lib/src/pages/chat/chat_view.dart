import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:together_flutter/src/constants/api_constants.dart';
import 'package:together_flutter/src/constants/color_constants.dart';
import 'package:together_flutter/src/constants/dimen_constants.dart';
import 'package:together_flutter/src/controllers/chat/chat_controller.dart';
import 'package:together_flutter/src/utils.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "프로젝트 채팅",
          ),
          centerTitle: false,
        ),
        body: Obx(
          () {
            if (controller.firebaseCode.value == FirebaseCode.loading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: subColor,
                ),
              );
            } else if (controller.firebaseCode.value == FirebaseCode.failed) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("예상치 못한 오류가 발생했습니다"),
                    const SizedBox(
                      height: kSmallSpace,
                    ),
                    InkWell(
                      onTap: () {},
                      customBorder: const CircleBorder(),
                      splashColor: Colors.red,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 1,
                                  spreadRadius: 1)
                            ]),
                        child: const Icon(Icons.sync),
                      ),
                    )
                  ],
                ),
              );
            } else if (controller.firebaseCode.value == FirebaseCode.success) {
              return ListView.builder(
                  itemCount: controller.rooms.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        controller.enterRoom(index);
                        Get.toNamed("/ChatDetail",
                            arguments: controller.rooms[index].project.obs);
                      },
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    controller.rooms[index].project.profile!),
                                fit: BoxFit.fill)),
                      ),
                      title: Text(
                        controller.rooms[index].project.title,
                        style: const TextStyle(fontSize: 14),
                        maxLines: 1,
                      ),
                      subtitle: Obx(() => Text(
                            controller.rooms[index].lastMessage.value,
                            style: const TextStyle(
                                fontSize: 12, color: dividerColor),
                            maxLines: 1,
                          )),
                      trailing: Obx(() => SizedBox(
                            width: 100,
                            height: 40,
                            child: Column(
                              mainAxisAlignment:
                                  controller.rooms[index].unreadCnt.value == 0
                                      ? MainAxisAlignment.center
                                      : MainAxisAlignment.start,
                              children: [
                                controller.rooms[index].lastMessage.value !=
                                        "채팅 내역이 없습니다"
                                    ? Text(
                                        Utils.formatDate(
                                            controller
                                                .rooms[index].lastTime.value,
                                            "-"),
                                        style: const TextStyle(
                                            fontSize: 12, color: dividerColor),
                                      )
                                    : Container(),
                                controller.rooms[index].unreadCnt.value != 0
                                    ? CircleAvatar(
                                        backgroundColor: Colors.red,
                                        radius: 10,
                                        child: Text(
                                          controller.rooms[index].unreadCnt
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          )),
                    );
                  });
            } else {
              return Container();
            }
          },
        ));
  }
}
