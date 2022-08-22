import 'dart:io';
import 'dart:typed_data';

import 'package:aptcoder/bloc/student/student_bloc.dart';
import 'package:aptcoder/data/student_profile_service.dart';
import 'package:aptcoder/model/student.dart';
import 'package:aptcoder/service/picker_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileStateWithStudent> {
  final StudentBloc bloc;
  ProfileBloc(Student s, this.bloc) : super(ProfileInitial(s)) {
    on<ProfileEvent>((event, emit) async {
      if (event is UpdateProfile) {
        try {
          String? picUrl;
          if (event.profilePic != null) {
            picUrl = await StudentProfileService.uploadStudentProfilePic(event.student, event.profilePic!);
          }

          final newStudent = event.student.copyWith(
            course: event.course,
            institute: event.institute,
            sem: event.sem,
            rollNo: event.rollNo,
            profilePic: picUrl,
          );
          await StudentProfileService.updateStudentProfile(newStudent);
          bloc.add(FetchStudentEvent());
          emit(UpdateSuccessState(newStudent));
        } catch (e) {
          emit(UpdateFailureState("Couldn't Upload Student details", event.student));
        }
      }

      if (event is EditProfile) {
        emit(EditProfileState(event.label, event.student));
      }
      if (event is CancelUpdateMode) {
        emit(ProfileInitial(event.student));
      }
      if (event is ProfilePicUpload) {
        final file = await FileService.pickGalleryImage();
        if (file != null) {
          final bytes = await File(file.path).readAsBytes();
          emit(UpdateProfileProgress(state.student));
          add(UpdateProfile(event.student, profilePic: bytes));
        }
      }
    });
  }
}
