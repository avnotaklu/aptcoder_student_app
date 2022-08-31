import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/core/usecases/usecase.dart';
import 'package:aptcoder/features/domain/entities/authentication/user.dart';
import 'package:aptcoder/features/domain/entities/student/student.dart';
import 'package:aptcoder/features/domain/repositories/student_dashboard/student_repository.dart';
import 'package:dartz/dartz.dart';

class GetStudentInfo extends UseCase<Student, GetStudentParams> {
  final StudentRepository repository;
  GetStudentInfo(this.repository);
  @override
  Future<Either<Failure, Student>> call(GetStudentParams params) async {
    final user = params.user;

    final result = await repository.getStudentUser(params.user.uid);
    return result;
  }
}

class GetStudentParams {
  final AuthUser user;
  GetStudentParams(this.user);
}
