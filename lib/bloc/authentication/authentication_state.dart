// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitialState extends AuthenticationState {}

class AuthorizationPromptState extends AuthenticationState {}

class UnAuthorizedState extends AuthenticationState {
  final String error;
  UnAuthorizedState({
    required this.error,
  });
}

class AuthorizedState extends AuthenticationState {
  final User user;
  final Usertype type;

  AuthorizedState(this.user, this.type);
}

class LoginProgressState extends AuthenticationState {}

class LogoutState extends AuthenticationState {}

class NewUserAuthenticated extends AuthenticationState {
  final User user;
  final Usertype type;

  NewUserAuthenticated(this.user, this.type);
}
