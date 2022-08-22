// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Admin {
  final String name;
  final String? profilePic;
  final String uid;

  Admin({required this.name, required this.profilePic, required this.uid});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'profilePic': profilePic,
      'uid': uid,
    };
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      name: map['name'] as String,
      profilePic: map['profilePic'] as String,
      uid: map['uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Admin.fromJson(String source) => Admin.fromMap(json.decode(source) as Map<String, dynamic>);
}
