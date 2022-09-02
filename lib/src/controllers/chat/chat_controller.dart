import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:together_flutter/src/constants/api_constants.dart';
import 'package:together_flutter/src/controllers/home/home_controller.dart';
import 'package:together_flutter/src/controllers/onboarding/auth_controller.dart';
import 'package:together_flutter/src/models/project.dart';
import 'package:together_flutter/src/models/chat.dart';

class ChatController extends GetxController {
  static ChatController get to => Get.find();

  RxList<Room> rooms = RxList([]);
  RxList<Project> projects = RxList([]);
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Rx<FirebaseCode> firebaseCode = FirebaseCode.init.obs;

  RxInt currentRoomIdx = 0.obs;

  @override
  void onInit() {
    projects(HomeController.to.projects);

    HomeController.to.projects.listen((p0) {
      projects(HomeController.to.projects);
    });

    loadChatThumbnail();

    super.onInit();
  }

  enterRoom(int index) {
    currentRoomIdx(index);
  }

  Rx<Project> get currentRoom => projects[currentRoomIdx.value].obs;

  loadChatThumbnail() {
    firebaseCode(FirebaseCode.loading);

    for (var element in projects) {
      rooms.add(Room(
          project: element,
          lastMessage: ''.obs,
          lastTime: DateTime.now().obs,
          unreadCnt: 0.obs));
    }

    try {
      for (var project in projects) {
        var index = projects.indexOf(project);

        firestore
            .collection(projectCollection)
            .doc(project.id)
            .collection(chatCollection)
            .orderBy("message_date", descending: true)
            .limit(1)
            .snapshots()
            .listen((event) {
          if (event.docs.isNotEmpty) {
            rooms[index].lastMessage(event.docs.first.data()["message_title"]);
            rooms[index]
                .lastTime(event.docs.first.data()["message_date"].toDate());
          } else {
            rooms[index].lastMessage("채팅 내역이 없습니다");
          }
        });

        firestore
            .collection(projectCollection)
            .doc(project.id)
            .collection(chatCollection)
            .where("message_unread_users",
                arrayContainsAny: [AuthController.to.uid])
            .snapshots()
            .listen((event) {
              rooms[index].unreadCnt = event.docs.length.obs;
            });
        // print("unread" + data.docs.length.toString());

      }
      rooms.refresh();
      firebaseCode(FirebaseCode.success);
    } catch (e) {
      firebaseCode(FirebaseCode.failed);
    }
  }
}
