import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  String? id;
  String title;
  String note;
  Timestamp startTime;
  Timestamp endTime;
  String writer;

  Schedule(
      {required this.title,
      this.id,
      required this.note,
      required this.startTime,
      required this.endTime,
      required this.writer});

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "note": note,
      "start_time": startTime,
      "end_time": endTime,
      "writer": writer
    };
  }

  factory Schedule.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> document) {
    var json = document.data();
    return Schedule(
      id: document.id,
      title: json['title'],
      note: json['note'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      writer: json['writer'],
    );
  }
}
