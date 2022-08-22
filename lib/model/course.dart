// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

enum CourseType { video, ppt, pdf }

@immutable
class Course {
  final String name;
  late final String id;
  final CourseType type;
  final String resourceUrl;
  final String resourceName;
  final String imageUrl;

  const Course({
    required this.name,
    required this.type,
    required this.resourceUrl,
    required this.imageUrl,
    required this.id,
    required this.resourceName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'type': type.name,
      'resourceUrl': resourceUrl,
      'resourceName': resourceName,
      'imageUrl': imageUrl,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      name: map['name'] as String,
      type: CourseType.values.byName(map['type'] as String),
      id: map['id'] as String,
      resourceUrl: map['resourceUrl'] as String,
      resourceName: map['resourceName'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) => Course.fromMap(json.decode(source) as Map<String, dynamic>);
}
