part of 'student_bloc.dart';

@immutable
abstract class StudentEvent {}

class FetchStudentEvent extends StudentEvent {}

class AddStudentEvent extends StudentEvent {
  final User user;

  AddStudentEvent(this.user);
}

class StudentViewCourse extends StudentEvent {
  final Student student;
  final Course course;

  StudentViewCourse(this.student, this.course);
}
