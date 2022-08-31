import 'package:aptcoder/core/error/app_exception.dart';
import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/features/data/datasources/student_dashboard/student_remote_data_source.dart';
import 'package:aptcoder/features/domain/entities/courses/course.dart';
import 'package:aptcoder/features/domain/entities/student/student.dart';
import 'package:aptcoder/features/domain/entities/student/view_activity.dart';
import 'package:aptcoder/features/domain/repositories/student_dashboard/student_repository.dart';
import 'package:dartz/dartz.dart';

class StudentRepositoryImpl implements StudentRepository {
  final StudentRemoteDataSource dataSource;
  StudentRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<Course>>> getStudentLastViewedCourses(List<ViewActivity> activities) async {
    try {
      return Right((await dataSource.getStudentLastViewedCourses(activities)));
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Student>> getStudentUser(String id) async {
    try {
      return Right((await dataSource.fetchStudent(id)));
    } on StudentNonExistantException catch (e) {
      return Left(StudentNonExistantFailure());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }


  @override
  Future<Either<Failure, void>> viewCourse(Student student, ViewActivity viewActivity) async {
    try {
      return Right(await dataSource.addCourse(student, viewActivity));
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }
}
