part of 'admin_bloc.dart';

@immutable
abstract class AdminState {}

class AdminInitial extends AdminState {}

class AdminLoadedState extends AdminState {
  final Admin admin;

  AdminLoadedState(this.admin);
}

class AdminErrorState extends AdminState {
  final String error;

  AdminErrorState(this.error);
}

class CoursesDeleteSuccessState extends AdminState {}

class CoursesDeleteFailureState extends AdminState {
  final String error;

  CoursesDeleteFailureState(this.error);
}

class NewAdminCreatingState extends AdminState {}
