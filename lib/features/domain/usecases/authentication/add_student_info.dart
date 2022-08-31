import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/core/usecases/usecase.dart';
import 'package:aptcoder/features/domain/entities/student/student.dart';
import 'package:aptcoder/features/domain/repositories/authentication/authentication_repository.dart';
import 'package:aptcoder/features/domain/usecases/student_dashboard/get_student_info.dart';
import 'package:dartz/dartz.dart';

class AddStudentInfo extends UseCase<Student, GetStudentParams> {
  final AuthenticationRepository repository;

  AddStudentInfo(this.repository);

  @override
  Future<Either<Failure, Student>> call(GetStudentParams params) async {
    final result = await repository.registerNewStudent(Student(
        uid: params.user.uid,
        name: params.user.displayName,
        course: null,
        institute: null,
        sem: null,
        rollNo: null,
        profilePic: params.user.profilePic,
        lastViewedCourses: const []));
    return result.fold((l) => Left(l), (r) {
      return Right(NewStudent.fromStudent(r));
    });
  }
}
