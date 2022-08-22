part of 'admin_bloc.dart';

@immutable
abstract class AdminEvent {}

class NewCourseAdded extends AdminEvent {}

class DeleteCourseEvent extends AdminEvent {
  final Course course;

  DeleteCourseEvent(this.course);
}

class AddAdminEvent extends AdminEvent {
  final User user;

  AddAdminEvent(this.user);
}
