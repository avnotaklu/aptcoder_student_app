import 'dart:typed_data';

import 'package:aptcoder/model/student.dart';
import 'package:aptcoder/model/view_activity.dart';
import 'package:aptcoder/service/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentProfileService {
  static String collectionPath = 'students';
  static Future<void> addNewUser(Student student) async {
    db.collection(collectionPath).doc(student.uid).set(student.toMap());
  }

  static Future<void> addNewViewedCourse(Student student, ViewActivity course) async {
    if (student.lastViewedCourses.any(((element) => element.resource == course.resource))) {
      await db.collection(collectionPath).doc(student.uid).update({
        'lastViewedCourses': FieldValue.arrayRemove(
            [student.lastViewedCourses.firstWhere(((element) => element.resource == course.resource)).toMap()]),
      });

      await db.collection(collectionPath).doc(student.uid).update({
        'lastViewedCourses': FieldValue.arrayUnion([course.toMap()]),
      });
    } else {
      await db.collection(collectionPath).doc(student.uid).update({
        'lastViewedCourses': FieldValue.arrayUnion([course.toMap()]),
      });
    }
  }

  static Future<Student> getStudentDoc(String uid) async {
    return Student.fromMap((await db.collection(collectionPath).doc(uid).get()).data() as Map<String, dynamic>);
  }

  static Future<void> updateStudentProfile(Student student) async {
    await db.collection(collectionPath).doc(student.uid).update(student.toMap());
  }

  static Future<String> uploadStudentProfilePic(Student student, Uint8List profilePic) async {
    var ref = storage.ref('student/${student.uid}');
    await ref.putData(profilePic);
    return ref.getDownloadURL();
  }
}
