part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {
  final Student student;

  const ProfileEvent(this.student);
}

class UpdateProfile extends ProfileEvent {
  final String? course;
  final String? institute;
  final int? sem;
  final int? rollNo;
  final Uint8List? profilePic;
  final String? name;

  const UpdateProfile(super.student, {this.course, this.institute, this.sem, this.rollNo, this.profilePic, this.name})
      : assert(
            course != null || institute != null || sem != null || rollNo != null || profilePic != null || name != null);
}

class EditProfile extends ProfileEvent {
  final String label;
  const EditProfile(this.label, super.student);
}

class CancelUpdateMode extends ProfileEvent {
  const CancelUpdateMode(super.student);
}

class ProfilePicUpload extends ProfileEvent {
  const ProfilePicUpload(super.student);
}
