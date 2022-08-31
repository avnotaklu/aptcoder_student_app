import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/features/data/datasources/courses/remote_course_data_source.dart';
import 'package:aptcoder/features/domain/entities/courses/course.dart';
import 'package:aptcoder/features/domain/repositories/courses/course_repository.dart';
import 'package:dartz/dartz.dart';

class CourseRepositoryImpl extends CourseRepository {
  final RemoteCourseDataSource dataSource;

  CourseRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, List<Course>>> getAllCourses() async {
    try {
      return Right(await dataSource.getAllCourses());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }
}
