import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/features/domain/entities/courses/course.dart';
import 'package:aptcoder/features/domain/entities/student/student.dart';
import 'package:aptcoder/features/domain/entities/student/view_activity.dart';
import 'package:dartz/dartz.dart';

abstract class StudentRepository {
  Future<Either<Failure, Student>> getStudentUser(String id);
  Future<Either<Failure, List<Course>>> getStudentLastViewedCourses(List<ViewActivity> activities);
  Future<Either<Failure, void>> viewCourse(Student student, ViewActivity viewActivity);
}
