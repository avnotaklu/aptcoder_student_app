import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/core/usecases/usecase.dart';
import 'package:aptcoder/features/domain/entities/courses/course.dart';
import 'package:aptcoder/features/domain/entities/student/student.dart';
import 'package:aptcoder/features/domain/repositories/student_dashboard/student_repository.dart';
import 'package:dartz/dartz.dart';

class GetStudentLastCourses extends UseCase<List<Course>, GetStudentLastCoursesParams> {
  final StudentRepository repository;
  GetStudentLastCourses(this.repository);
  @override
  Future<Either<Failure, List<Course>>> call(GetStudentLastCoursesParams params) async {
    return await repository.getStudentLastViewedCourses(params.student.lastViewedCourses);
  }
}

class GetStudentLastCoursesParams {
  final Student student;

  GetStudentLastCoursesParams(this.student);
}
