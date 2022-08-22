import 'dart:async';

import 'package:aptcoder/bloc/authentication/authentication_bloc.dart';
import 'package:aptcoder/data/student_profile_service.dart';
import 'package:aptcoder/model/student.dart';
import 'package:aptcoder/service/auth.dart';
import 'package:aptcoder/service/user.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitialState()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is LoginEvent) {
        try {
          final UserCredential userCred = await AppAuthentication.loginInAndGetCreds();
          final bool isNewUser = userCred.additionalUserInfo?.isNewUser ?? false;
          if (isNewUser) {
            emit(
              NewUserAuthenticated(userCred.user!, event.type),
            );
          } else if (userCred.user != null) {
            final type = await UserService.getUsertype(userCred.user!);
            if (type == null || type == event.type) {
              emit(AuthorizedState(userCred.user!, event.type));
            } else {
              emit(UnAuthorizedState(error: "${type.name} user exists with this one\nUse another email"));
            }
          } else {
            emit(UnAuthorizedState(error: "User not found"));
          }
        } catch (e) {
          emit(UnAuthorizedState(error: "Authentication Error"));
        }
      }
      if (event is InitialAuthCheckEvent) {
        try {
          final user = AppAuthentication.getCurrentUser;
          final type = await UserService.getUsertype(user!);
          if (user != null) {
            emit(AuthorizedState(user, type!));
          } else {
            emit(AuthorizationPromptState());
          }
        } catch (e) {
          emit(AuthorizationPromptState());
        }
      }
      if (event is LoginRequestedEvent) {
        emit(LoginProgressState());
        add(LoginEvent(event.type));
      }
      if (event is LogoutEvent) {
        await AppAuthentication.logout();
        emit(LogoutState());
      }
    });
  }
}
