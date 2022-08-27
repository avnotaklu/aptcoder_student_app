import 'dart:typed_data';

import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/core/usecases/usecase.dart';
import 'package:aptcoder/features/student_dashboard/domain/entities/student.dart';
import 'package:aptcoder/features/student_profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

// TODO: what to do with this
class UploadProfilePic extends UseCase<void, UploadStudentProfilePicParams> {
  final ProfileRepository repository;

  UploadProfilePic(this.repository);

  @override
  Future<Either<Failure, void>> call(UploadStudentProfilePicParams params) async {
    return await repository.updateStudentProfile(params.student);
  }
}

class UploadStudentProfilePicParams {
  final Student student;
  final Uint8List? profilePic;
  UploadStudentProfilePicParams(this.student, this.profilePic);
}
