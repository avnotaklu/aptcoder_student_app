import 'dart:io';
import 'dart:typed_data';
import 'package:aptcoder/service/picker_service.dart';
import 'package:aptcoder/bloc/admin/admin_bloc.dart';
import 'package:aptcoder/data/courses_service.dart';
import 'package:aptcoder/model/course.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'course_create_event.dart';
part 'course_create_state.dart';

class CourseCreateBloc extends Bloc<CourseCreateEvent, CourseCreateState> {
  CourseCreateBloc() : super(CourseCreateInitial()) {
    on<CourseCreateEvent>((event, emit) async {
      if (event is ResetCourseCreateDialog) {
        emit(CourseCreateInitial());
      }

      if (event is CreateCourseEventRequested) {
        emit(CreateCourseInProgress());
        add(CreateCourseEventProgress(
            event.name, event.type, event.resource, event.image, event.filename, event.imageName));
      } else if (event is CreateCourseEventProgress) {
        try {
          final resourceUrl = await CoursesService.uploadResources(event.resource!, "res", event.filename!);
          final imageUrl = await CoursesService.uploadResources(event.image!, "img", event.imageName!);
          await CoursesService.createCourse(Course(
            name: event.name!,
            type: event.type!,
            resourceUrl: resourceUrl,
            imageUrl: imageUrl,
            id: await CoursesService.getNewDocId(),
            resourceName: event.filename!,
          ));
          emit(CoursesCreateSuccessState());
        } catch (e) {
          emit(CoursesCreateFailureState("Please enter correct fields"));
        }
      }
      if (event is ResourceLoadEvent) {
        try {
          final allowedFileType;
          switch ((state as CourseCreateInitial).type!) {
            case CourseType.video:
              allowedFileType = "mp4";
              break;
            case CourseType.ppt:
              allowedFileType = "ppt";
              break;
            case CourseType.pdf:
              allowedFileType = "pdf";
              break;
          }

          final file = await FileService.pickFile([allowedFileType]);
          final bytes = file?.path != null ? await File(file!.path!).readAsBytes() : null;
          emit((state as CourseCreateInitial).copyWith(resource: bytes, filename: file?.name));
        } catch (e) {
          final tmp = CourseCreateInitial().copyWith();
          emit(CoursesCreateFailureState("Please enter type first"));
        }
      }
      if (event is ImageLoadEvent) {
        final file = await FileService.pickGalleryImage();
        final bytes = file?.path == null ? null : await File(file!.path).readAsBytes();
        emit((state as CourseCreateInitial).copyWith(image: bytes, imageName: file?.name));
      }
      if (event is TypeChangeEvent) {
        emit((state as CourseCreateInitial).copyWith(type: event.type));
      }
    });
  }
}
