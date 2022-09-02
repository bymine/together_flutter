import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:together_flutter/src/models/project.dart';

class Room {
  Project project;
  RxString lastMessage;
  RxInt unreadCnt;
  Rx<DateTime> lastTime;

  Room(
      {required this.project,
      required this.lastMessage,
      required this.unreadCnt,
      required this.lastTime});
}

class ChatProfile {
  String uid;
  String name;
  String profile;
  bool active;

  ChatProfile(
      {required this.uid,
      required this.name,
      required this.profile,
      required this.active});
}

class Message {
  String? idx;
  String title;
  Timestamp date;
  String writer;
  List<String> unReadUsers;

  Message(
      {required this.title,
      required this.date,
      required this.writer,
      required this.unReadUsers,
      this.idx});

  Map<String, dynamic> toMap() {
    return {
      'message_title': title,
      'message_date': date,
      'message_writer': writer,
      'message_unread_users': unReadUsers
    };
  }

  factory Message.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> documnet) {
    var json = documnet.data();
    return Message(
        idx: documnet.id,
        title: json['message_title'],
        date: json['message_date'],
        unReadUsers: List<String>.from(json['message_unread_users']),
        writer: json['message_writer']);
  }
}
