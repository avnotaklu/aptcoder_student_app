import 'package:aptcoder/bloc/authentication/authentication_bloc.dart';
import 'package:aptcoder/data/courses_service.dart';
import 'package:aptcoder/model/admin.dart';
import 'package:aptcoder/model/course.dart';
import 'package:aptcoder/service/admin_service.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AuthenticationBloc auth;
  AdminBloc(this.auth) : super(AdminInitial()) {
    on<AdminEvent>((event, emit) async {
      if (event is AddAdminEvent) {
        try {
          final admin = Admin(
            profilePic: event.user.photoURL,
            uid: event.user.uid,
            name: event.user.displayName ?? "Unknown",
          );
          await AdminService.addNewAdmin(admin);

          emit(AdminLoadedState(admin));
        } catch (e) {
          emit(AdminErrorState("There was a problem"));
        }
      }

      if (event is DeleteCourseEvent) {
        try {
          await CoursesService.deleteCourse(event.course);
          emit(CoursesDeleteSuccessState());
        } catch (e) {
          emit(CoursesDeleteFailureState(e.toString()));
        }
      }
    });
  }
}
