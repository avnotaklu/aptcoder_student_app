import 'package:flutter/foundation.dart';

enum CourseType { video, ppt, pdf }

class Course {
  final String name;
  late final String id;
  final CourseType type;
  final String resourceUrl;
  final String resourceName;
  final String imageUrl;

  Course({
    required this.name,
    required this.type,
    required this.resourceUrl,
    required this.imageUrl,
    required this.id,
    required this.resourceName,
  });
}
