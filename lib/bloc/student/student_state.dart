part of 'student_bloc.dart';

@immutable
abstract class StudentState {}

class StudentInitial extends StudentState {}

class StudentLoadedState extends StudentState {
  final Student student;
  final List<Course> viewedCourses;
  StudentLoadedState(this.student, this.viewedCourses);
}

class NewStudentCreatingState extends StudentState {}

class StudentErrorState extends StudentState {
  final String error;

  StudentErrorState(this.error);
}