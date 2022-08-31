import 'package:aptcoder/features/domain/entities/authentication/user.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;
  Failure(this.properties);

  @override
  List<Object?> get props => properties;
}

class UnexpectedFailure extends Failure {
  UnexpectedFailure() : super([]);
}

class NullFailure extends Failure {
  NullFailure() : super([]);
}

class UserAdminNotStudent extends Failure {
  UserAdminNotStudent() : super([]);
}

class StudentNonExistantFailure extends Failure {
  StudentNonExistantFailure() : super([]);
}

class InvalidUser extends Failure {
  InvalidUser() : super([]);
}

class IncorrectAccountRequested extends Failure {
  final Usertype requested;
  final Usertype exists;
  IncorrectAccountRequested(this.requested, this.exists) : super([requested, exists]);
}

class UserNotFound extends Failure {
  UserNotFound() : super([]);
}

class AdminNonExistantFailure extends Failure {
  AdminNonExistantFailure() : super([]);
}
