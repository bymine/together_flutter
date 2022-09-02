import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  String? id;
  String title;
  String note;
  String? password;
  int? maxMember;
  String? profile;
  List<Map<String, dynamic>> users;

  Project({
    required this.title,
    required this.note,
    required this.users,
    this.id,
    this.password,
    this.maxMember,
    this.profile =
        "https://firebasestorage.googleapis.com/v0/b/together-flutter.appspot.com/o/sample%2Fblank_project.png?alt=media&token=5282c24e-35bd-4b13-8177-82b82be11608",
  });

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "note": note,
      "password": password,
      "maxMember": maxMember,
      "profile": profile,
      "user": users
    };
  }

  factory Project.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> document) {
    var json = document.data();
    return Project(
        id: document.id,
        title: json['title'],
        note: json['note'],
        users: List<Map<String, dynamic>>.from(json['user']),
        password: json['password'],
        maxMember: json['maxMember'],
        profile: json['profile']);
  }

  factory Project.fromJson(DocumentSnapshot<Map<String, dynamic>> document) {
    var json = document.data()!;
    return Project(
        id: document.id,
        title: json['title'],
        note: json['note'],
        users: List<Map<String, dynamic>>.from(json['user']),
        password: json['password'],
        maxMember: json['maxMember'],
        profile: json['profile']);
  }
}
