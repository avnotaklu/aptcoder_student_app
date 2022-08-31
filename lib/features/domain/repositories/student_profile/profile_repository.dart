import 'dart:typed_data';

import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/features/domain/entities/student/student.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Student>> updateStudentProfile(Student student);
  Future<Either<Failure, String>> uploadStudentProfilePic(Student student, Uint8List profilePic);
}
