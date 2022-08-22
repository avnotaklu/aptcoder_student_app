part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class InitialAuthCheckEvent extends AuthenticationEvent {}

class LoginEvent extends AuthenticationEvent {
  final Usertype type;
  LoginEvent(this.type);
}

class LoginRequestedEvent extends AuthenticationEvent {
  final Usertype type;
  LoginRequestedEvent(this.type);
}

class LogoutEvent extends AuthenticationEvent {}
