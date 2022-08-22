part of 'profile_bloc.dart';

@immutable
abstract class ProfileStateWithStudent {
  final Student student;

  const ProfileStateWithStudent(this.student);
}

class ProfileInitial extends ProfileStateWithStudent {
  const ProfileInitial(student) : super(student);
}

class UpdateProfileProgress extends ProfileStateWithStudent {
  const UpdateProfileProgress(student) : super(student);
}

class UpdateFailureState extends ProfileStateWithStudent {
  final String error;

  const UpdateFailureState(this.error, student) : super(student);
}

class UpdateSuccessState extends ProfileStateWithStudent {
  const UpdateSuccessState(student) : super(student);
}

class EditProfileState extends ProfileStateWithStudent {
  final String label;

  const EditProfileState(this.label, student) : super(student);
}
