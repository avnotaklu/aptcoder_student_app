import 'dart:typed_data';
import 'package:aptcoder/features/data/models/student/student.dart';
import 'package:aptcoder/features/domain/entities/student/student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class ProfileRemoteDataSource {
  Future<void> updateStudentProfile(Student student);
  Future<String> uploadStudentProfilePic(Student student, Uint8List profilePic);
}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  final FirebaseStorage storage;
  final FirebaseFirestore db;

  ProfileRemoteDataSourceImpl(this.storage, this.db);

  @override
  Future<void> updateStudentProfile(Student student) async {
    await db.collection('students').doc(student.uid).update(StudentModel(
            uid: student.uid,
            name: student.name,
            course: student.course,
            institute: student.institute,
            sem: student.sem,
            rollNo: student.rollNo,
            profilePic: student.profilePic,
            lastViewedCourses: student.lastViewedCourses)
        .toMap());
  }

  @override
  Future<String> uploadStudentProfilePic(Student student, Uint8List profilePic) async {
    var ref = storage.ref('student/${student.uid}');
    await ref.putData(profilePic);
    return ref.getDownloadURL();
  }
}
