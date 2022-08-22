part of 'profile_bloc.dart';

@immutable
abstract class ProfileStateWithStudent {
  final Student student;

  ProfileStateWithStudent(this.student);
}

class ProfileInitial extends ProfileStateWithStudent {
  ProfileInitial(student) : super(student);
}

class UpdateProfileProgress extends ProfileStateWithStudent {
  UpdateProfileProgress(student) : super(student);
}

class UpdateFailureState extends ProfileStateWithStudent {
  final String error;

  UpdateFailureState(this.error, student) : super(student);
}

class UpdateSuccessState extends ProfileStateWithStudent {
  UpdateSuccessState(student) : super(student);
}

class EditProfileState extends ProfileStateWithStudent {
  final String label;

  EditProfileState(this.label, student) : super(student);
}
