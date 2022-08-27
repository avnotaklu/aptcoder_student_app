import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/core/usecases/usecase.dart';
import 'package:aptcoder/features/login/domain/entities/user.dart';
import 'package:aptcoder/features/student_dashboard/data/core/exception.dart';
import 'package:aptcoder/features/student_dashboard/domain/core/failures.dart';
import 'package:aptcoder/features/student_dashboard/domain/entities/student.dart';
import 'package:aptcoder/features/student_dashboard/domain/repositories/student_repository.dart';
import 'package:dartz/dartz.dart';

class GetStudentInfo extends UseCase<Student, GetStudentParams> {
  final StudentRepository repository;
  GetStudentInfo(this.repository);
  @override
  Future<Either<Failure, Student>> call(GetStudentParams params) async {
    final user = params.user;

    if (params.user.isNewUser) {
      // Map User to Student Logic
      final result = await repository.registerNewStudent(Student(
          uid: user.uid,
          name: user.displayName,
          course: null,
          institute: null,
          sem: null,
          rollNo: null,
          profilePic: user.profilePic,
          lastViewedCourses: const []));
      return result.fold((l) => Left(l), (r) {
        return Right(NewStudent.fromStudent(r));
      });
    } else {
      final result = await repository.getStudentUser(params.user.uid);
      return result;
    }
  }
}

class GetStudentParams {
  final AuthUser user;
  GetStudentParams(this.user);
}
