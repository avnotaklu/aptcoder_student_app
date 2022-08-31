import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/features/domain/entities/courses/course.dart';
import 'package:dartz/dartz.dart';

abstract class CourseRepository {
  Future<Either<Failure, List<Course>>> getAllCourses();
}
