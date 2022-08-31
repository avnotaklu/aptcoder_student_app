import 'package:aptcoder/core/service/picker_service.dart';
import 'package:aptcoder/features/domain/entities/courses/course.dart';
import 'package:aptcoder/features/domain/entities/student/student.dart';
import 'package:aptcoder/features/domain/usecases/student_dashboard/get_student_info.dart';
import 'package:aptcoder/features/domain/usecases/student_dashboard/get_student_last_courses.dart';
import 'package:aptcoder/features/domain/usecases/student_dashboard/view_course.dart';
import 'package:aptcoder/features/presentation/pages/authentication/authentication_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'student_dashboard_event.dart';
part 'student_dashboard_state.dart';

class StudentDashboardBloc extends Bloc<StudentDashboardEvent, StudentDashboardState> {
  final AuthenticationBloc _authenticationBloc;
  final GetStudentInfo _studentInfo;
  final GetStudentLastCourses _studentLastCourses;
  final ViewCourse viewCourse;

  StudentDashboardBloc(this._authenticationBloc, this._studentInfo, this._studentLastCourses, this.viewCourse)
      : assert(_authenticationBloc.state is AuthorizedState),
        super(StudentDashboardInitial((_authenticationBloc.state as AuthorizedState).user.isNewUser)) {
    on<StudentDashboardEvent>((event, emit) async {
      if (event is FetchStudentEvent) {
        // type cast Works because auth state is asserted to be Authorized
        final result = await _studentInfo(GetStudentParams((_authenticationBloc.state as AuthorizedState).user));

        await (result.fold((l) async => emit(StudentErrorState("There was a problem")), (student) async {
          final coursesResult = await _studentLastCourses(GetStudentLastCoursesParams(student));
          coursesResult.fold((l) => StudentLastCoursesErrorState("Unable to load last viewed courses"), (courses) {
            emit(StudentLoadedState(student, courses));
          });
        }));
      }
      if (event is StudentViewCourse) {
        FileService.openfile(url: event.course.resourceUrl, filename: event.course.resourceName);

        final result = await viewCourse(ViewCourseParams(event.student, event.course));
        result.fold(
            (l) => emit(StudentViewCourseErrorState("Sorry there was a problem")), (r) => add(FetchStudentEvent()));
      }
    });
  }
}
