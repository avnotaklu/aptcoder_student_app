import 'package:aptcoder/data/courses_service.dart';
import 'package:aptcoder/model/course.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  CoursesBloc() : super(CoursesInitial()) {
    on<CoursesEvent>((event, emit) async {
      if (event is LoadCoursesEvent) {
        try {
          final courses = await CoursesService.fetchCourses();
          emit(CoursesLoadedState(courses));
        } catch (e) {
          emit(CoursesLoadingErrorState("There was a problem"));
        }
      }
    });
  }
}
/*  */