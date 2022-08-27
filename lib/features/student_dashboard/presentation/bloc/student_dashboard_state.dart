part of 'student_dashboard_bloc.dart';

abstract class StudentDashboardState extends Equatable {
  final List<Object> _props;
  const StudentDashboardState(this._props);

  @override
  List<Object> get props => [];
}

class StudentDashboardInitial extends StudentDashboardState {
  final bool creatingNewStudent;
  StudentDashboardInitial(this.creatingNewStudent) : super([creatingNewStudent]);
}

class StudentErrorState extends StudentDashboardState {
  final String error;
  StudentErrorState(this.error) : super([]);
}


class StudentViewCourseErrorState extends StudentDashboardState {
  final String error;
  StudentViewCourseErrorState(this.error) : super([]);
}

class StudentLastCoursesErrorState extends StudentDashboardState {
  final String error;
  StudentLastCoursesErrorState(this.error) : super([]);
}

class StudentLoadedState extends StudentDashboardState {
  final Student student;
  final List<Course> viewedCourses;
  const StudentLoadedState(this.student, this.viewedCourses) : super(const []);
}
