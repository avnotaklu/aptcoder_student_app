import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/features/domain/entities/authentication/user.dart';
import 'package:aptcoder/features/domain/entities/student/student.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, UserCredential>> login();
  // TODO: similar thing needs to be done for admin it should also be created through authentication not admin panel feature
  Future<Either<Failure, Student>> registerNewStudent(Student student);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure, Usertype>> getUserType(User user);
}
