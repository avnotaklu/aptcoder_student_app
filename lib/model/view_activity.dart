// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class ViewActivity {
  final String resource;
  final Timestamp time;

  const ViewActivity(this.resource, this.time);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'resource': resource, 'time': time};
  }

  factory ViewActivity.fromMap(Map<String, dynamic> map) {
    return ViewActivity(map['resource'] as String, map['time']);
  }

  String toJson() => json.encode(toMap());

  factory ViewActivity.fromJson(String source) => ViewActivity.fromMap(json.decode(source) as Map<String, dynamic>);
}
