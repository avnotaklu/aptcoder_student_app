// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:aptcoder/model/view_activity.dart';
import 'package:flutter/foundation.dart';

@immutable
class Student {
  final String uid;
  final String name;
  final String? course;
  final String? institute;
  final int? sem;
  final int? rollNo;
  final String? profilePic;
  final List<ViewActivity> lastViewedCourses;

  const Student(
      {required this.uid,
      required this.name,
      this.course,
      this.institute,
      this.sem,
      this.rollNo,
      this.profilePic,
      this.lastViewedCourses = const []});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'course': course,
      'institute': institute,
      'sem': sem,
      'rollNo': rollNo,
      'profilePic': profilePic,
      'lastViewedCourses': lastViewedCourses.map((e) => e.toMap()).toList(),
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
        uid: map['uid'] as String,
        name: map['name'] as String,
        course: map['course'],
        institute: map['institute'],
        sem: map['sem'],
        rollNo: map['rollNo'],
        profilePic: map['profilePic'],
        lastViewedCourses:
            List<ViewActivity>.from((map['lastViewedCourses'] as List).map((e) => ViewActivity.fromMap(e))));
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) => Student.fromMap(json.decode(source) as Map<String, dynamic>);

  Student copyWith({
    String? uid,
    String? name,
    String? course,
    String? institute,
    int? sem,
    int? rollNo,
    String? profilePic,
    List<ViewActivity>? lastViewedCourses,
  }) {
    return Student(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      course: course ?? this.course,
      institute: institute ?? this.institute,
      sem: sem ?? this.sem,
      rollNo: rollNo ?? this.rollNo,
      profilePic: profilePic ?? this.profilePic,
      lastViewedCourses: lastViewedCourses ?? this.lastViewedCourses,
    );
  }
}
