part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {
  final Student student;

  ProfileEvent(this.student);
}

class UpdateProfile extends ProfileEvent {
  final String? course;
  final String? institute;
  final int? sem;
  final int? rollNo;
  final Uint8List? profilePic;
  final String? name;

  UpdateProfile(super.student, {this.course, this.institute, this.sem, this.rollNo, this.profilePic, this.name})
      : assert(
            course != null || institute != null || sem != null || rollNo != null || profilePic != null || name != null);
}

class EditProfile extends ProfileEvent {
  final String label;
  EditProfile(this.label, super.student);
}

class CancelUpdateMode extends ProfileEvent {
  CancelUpdateMode(super.student);
}

class ProfilePicUpload extends ProfileEvent {
  ProfilePicUpload(super.student);
}
