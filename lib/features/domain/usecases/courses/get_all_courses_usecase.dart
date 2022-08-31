import 'package:aptcoder/core/empty_params.dart';
import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/core/usecases/usecase.dart';
import 'package:aptcoder/features/domain/entities/courses/course.dart';
import 'package:aptcoder/features/domain/repositories/courses/course_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllCourses extends UseCase<List<Course>, EmptyParams> {
  final CourseRepository repository;

  GetAllCourses(this.repository);
  @override
  Future<Either<Failure, List<Course>>> call(EmptyParams params) async {
    return await repository.getAllCourses();
  }
}
