// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'course_create_bloc.dart';

@immutable
abstract class CourseCreateState {}

class CourseCreateInitial extends CourseCreateState {
  final String? name;
  final Uint8List? resource;
  final Uint8List? image;
  final CourseType? type;
  final String? imageName;

  final String? filename;
  CourseCreateInitial({
    this.imageName,
    this.filename,
    this.name,
    this.resource,
    this.image,
    this.type,
  });

  CourseCreateInitial copyWith({
    String? name,
    Uint8List? resource,
    Uint8List? image,
    CourseType? type,
    String? imageName,
    String? filename,
  }) {
    return CourseCreateInitial(
      name: name ?? this.name,
      resource: resource ?? this.resource,
      image: image ?? this.image,
      type: type ?? this.type,
      imageName: imageName ?? this.imageName,
      filename: filename ?? this.filename,
    );
  }
}

// Courses states

class CreateCourseInProgress extends CourseCreateState {}

class CoursesCreateSuccessState extends CourseCreateState {}

class CoursesCreateFailureState extends CourseCreateState {
  final String error;
  CoursesCreateFailureState(this.error);
}
