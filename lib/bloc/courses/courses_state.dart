part of 'courses_bloc.dart';

@immutable
abstract class CoursesState {}

class CoursesInitial extends CoursesState {}

class CoursesLoadedState extends CoursesState {
  final List<Course> courses;

  CoursesLoadedState(this.courses);
}

class CoursesLoadingErrorState extends CoursesState {
  final String error;

  CoursesLoadingErrorState(this.error);
}