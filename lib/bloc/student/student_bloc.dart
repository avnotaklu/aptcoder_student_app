import 'package:aptcoder/bloc/authentication/authentication_bloc.dart';
import 'package:aptcoder/data/courses_service.dart';
import 'package:aptcoder/data/student_profile_service.dart';
import 'package:aptcoder/model/course.dart';
import 'package:aptcoder/model/student.dart';
import 'package:aptcoder/model/view_activity.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final AuthenticationBloc authBloc;
  StudentBloc(this.authBloc) : super(StudentInitial()) {
    on<StudentEvent>((event, emit) async {
      if (event is FetchStudentEvent) {
        if (authBloc.state is AuthorizedState) {
          try {
            final student = await StudentProfileService.getStudentDoc((authBloc.state as AuthorizedState).user.uid);
            final List<Course> lastViewed =
                await Future.wait(student.lastViewedCourses.map(((e) => CoursesService.fetchCourseFromId(e.resource))));
            emit(StudentLoadedState(student, lastViewed));
          } catch (e) {
            emit(StudentErrorState("There was a problem"));
          }
        } else if (authBloc.state is NewUserAuthenticated) {
          try {
            final student = await StudentProfileService.getStudentDoc((authBloc.state as NewUserAuthenticated).user.uid);
            final List<Course> lastViewed =
                await Future.wait(student.lastViewedCourses.map(((e) => CoursesService.fetchCourseFromId(e.resource))));
            emit(StudentLoadedState(student, lastViewed));
          } catch (e) {
            emit(StudentErrorState("There was a problem"));
          }

        }
      }

      if (event is StudentViewCourse) {
        await StudentProfileService.addNewViewedCourse(
            event.student, ViewActivity(event.course.id, Timestamp.fromDate(DateTime.now())));

        add(FetchStudentEvent());
      }

      if (event is AddStudentEvent) {
        try {
          final student = Student(
            profilePic: event.user.photoURL,
            uid: event.user.uid,
            name: event.user.displayName ?? "Unknown",
          );
          await StudentProfileService.addNewUser(student);

          emit(StudentLoadedState(student, const []));
        } catch (e) {
          emit(StudentErrorState("There was a problem"));
        }
      }
    });
  }
}
