import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:together_flutter/src/constants/api_constants.dart';
import 'package:together_flutter/src/controllers/chat/chat_controller.dart';
import 'package:together_flutter/src/controllers/onboarding/auth_controller.dart';
import 'package:together_flutter/src/models/chat.dart';
import 'package:together_flutter/src/models/project.dart';

class ChatDetailController extends GetxController {
  static ChatDetailController get to => Get.find();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController message = TextEditingController();
  RxList<Message> loadMessage = RxList([]);
  late Rx<Project> project;
  RxList<ChatProfile> chatUsers = RxList([]);
  RxMap<String, dynamic> userThumbnail = <String, dynamic>{}.obs;
  ScrollController scrollController = ScrollController();
  Rx<FirebaseCode> firebaseCode = FirebaseCode.init.obs;
  @override
  void onInit() {
    project = ChatController.to.currentRoom;
    ChatController.to.currentRoom.listen((p0) {
      project = ChatController.to.currentRoom;
    });

    super.onInit();

    activeChat();
    loadMessages();

    getMemberThumbNail();
    readMessageAll();
  }

  @override
  void onClose() {
    unActiveChat();
    super.onClose();
  }

  getMemberThumbNail() async {
    List<ChatProfile> member = [];

    for (var element in project.value.users) {
      var data =
          await firestore.collection(userCollection).doc(element['user']).get();

      var profile = ChatProfile(
          uid: element['user'],
          name: data.get('name'),
          profile: data.get('profile'),
          active: element['active']);

      member.add(profile);
    }

    chatUsers(member);
    firebaseCode(FirebaseCode.success);
  }

  activeChat() async {
    project = Get.arguments;

    var projectIdx = Get.arguments as Rx<Project>;

    var data = await firestore
        .collection(projectCollection)
        .doc(projectIdx.value.id)
        .get();

    List<Map<String, dynamic>> map =
        List<Map<String, dynamic>>.from(data.get('user'));

    map.firstWhere(
        (element) => element['user'] == AuthController.to.uid)['active'] = true;

    firestore
        .collection(projectCollection)
        .doc(projectIdx.value.id)
        .update({'user': map});
  }

  unActiveChat() async {
    var data = await firestore
        .collection(projectCollection)
        .doc(project.value.id)
        .get();

    List<Map<String, dynamic>> map =
        List<Map<String, dynamic>>.from(data.get('user'));

    map.firstWhere(
            (element) => element['user'] == AuthController.to.uid)['active'] =
        false;

    firestore
        .collection(projectCollection)
        .doc(project.value.id)
        .update({'user': map});
  }

  loadMessages() {
    firebaseCode(FirebaseCode.loading);
    firestore
        .collection(projectCollection)
        .doc(project.value.id)
        .collection(chatCollection)
        .orderBy("message_date", descending: false)
        .snapshots()
        .listen((event) {
      loadMessage(event.docs.map((e) => Message.fromJson(e)).toList());
    });
  }

  readMessageAll() {
    firestore
        .collection(projectCollection)
        .doc(project.value.id)
        .collection(chatCollection)
        .where("message_unread_users",
            arrayContainsAny: [AuthController.to.uid])
        .snapshots()
        .listen((event) {
          var unread = event.docs.map((e) => Message.fromJson(e)).toList();

          for (var element in unread) {
            element.unReadUsers.remove(AuthController.to.uid);

            firestore
                .collection(projectCollection)
                .doc(project.value.id)
                .collection(chatCollection)
                .doc(element.idx)
                .update({"message_unread_users": element.unReadUsers});
          }
        });
  }

  List<String> calUnActiveUser() {
    var map = project.value.users
        .where((element) => element['active'] == false)
        .toList();

    List<String> unread = [];
    for (var element in map) {
      unread.add(element['user']);
    }

    return unread;
  }

  sendMessage() {
    if (message.text.isNotEmpty) {
      var sendMessage = Message(
        title: message.text,
        date: Timestamp.fromDate(DateTime.now()),
        writer: AuthController.to.uid,
        unReadUsers: calUnActiveUser(),
      );

      firestore
          .collection(projectCollection)
          .doc(project.value.id)
          .collection(chatCollection)
          .add(sendMessage.toMap());

      FocusNode().dispose();
      message.clear();
    }
  }
}
