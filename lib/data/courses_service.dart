import 'dart:typed_data';

import 'package:aptcoder/model/course.dart';
import 'package:aptcoder/service/constants.dart';

class CoursesService {
  static const String coursesCollectionPath = 'courses';
  static Future<List<Course>> fetchCourses() async {
    return (await db.collection(coursesCollectionPath).get()).docs.map((e) => Course.fromMap(e.data())).toList();
  }

  static Future<Course> fetchCourseFromId(String id) async {
    return Course.fromMap((await db.collection(coursesCollectionPath).doc(id).get()).data() as Map<String, dynamic>);
  }

  static String getNewDocId() {
    final newDoc = db.collection(coursesCollectionPath).doc();
    return newDoc.id;
  }

  static Future<void> createCourse(Course course) async {
    try {
      await db.collection(coursesCollectionPath).doc(course.id).set(course.toMap());
    } catch (e) {
      throw Exception();
    }
  }

  static Future<void> deleteCourse(Course course) async {
    await db.collection(coursesCollectionPath).doc(course.id).delete();
  }

  static Future<String> uploadResources(Uint8List data, String type, String filename) async {
    var ref = storage.ref('course/${DateTime.now()}/$type/$filename');
    await ref.putData(data);
    return ref.getDownloadURL();
  }
}
