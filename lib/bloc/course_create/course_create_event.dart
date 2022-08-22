part of 'course_create_bloc.dart';

@immutable
abstract class CourseCreateEvent {}

class ResetCourseCreateDialog extends CourseCreateEvent {}

class CreateCourseEventRequested extends CourseCreateEvent {
  final CourseType? type;
  final Uint8List? resource;
  final Uint8List? image;
  final String? filename;
  final String? imageName;
  final String? name;

  CreateCourseEventRequested(this.name, this.type, this.resource, this.image, this.filename, this.imageName);
}

class CreateCourseEventProgress extends CourseCreateEvent {

  final CourseType? type;
  final Uint8List? resource;
  final Uint8List? image;
  final String? filename;
  final String? imageName;
  final String? name;

  CreateCourseEventProgress(this.name, this.type, this.resource, this.image, this.filename, this.imageName);
}

class ResourceLoadEvent extends CourseCreateEvent {}

class ImageLoadEvent extends CourseCreateEvent {}

class TypeChangeEvent extends CourseCreateEvent {
  final CourseType type;

  TypeChangeEvent(this.type);
}
