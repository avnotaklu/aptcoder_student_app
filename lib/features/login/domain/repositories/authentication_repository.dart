import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/features/login/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, UserCredential>> login();
  Future<Either<Failure, Usertype>> getUsertype(UserCredential creds);
}
