import 'package:cloud_firestore/cloud_firestore.dart';

class TogetherUser {
  String uid;
  String name;
  String email;
  String phone;
  String birth;
  String? profile =
      'https://firebasestorage.googleapis.com/v0/b/together-flutter.appspot.com/o/sample%2Fblank_profile.png?alt=media&token=a263c7de-e65a-43cf-b0af-d38dcd4fbf7c';

  TogetherUser(
      {required this.uid,
      required this.name,
      required this.email,
      required this.phone,
      required this.birth,
      this.profile});

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "phone": phone,
      "birth": birth,
      "profile": profile
    };
  }

  factory TogetherUser.fromJson(
      DocumentSnapshot<Map<String, dynamic>> document) {
    var json = document.data()!;
    return TogetherUser(
        uid: document.id,
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        birth: json['birth'],
        profile: json['profile']);
  }
}
