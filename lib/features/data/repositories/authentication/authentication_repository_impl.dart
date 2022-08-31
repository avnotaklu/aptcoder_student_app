import 'package:aptcoder/core/error/app_exception.dart';
import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/features/data/datasources/authentication/remote_authentication_data_source.dart';
import 'package:aptcoder/features/domain/entities/authentication/user.dart';
import 'package:aptcoder/features/domain/entities/student/student.dart';
import 'package:aptcoder/features/domain/repositories/authentication/authentication_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource remoteDataSource;

  AuthenticationRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserCredential>> login() async {
    try {
      final user = await remoteDataSource.login();
      if (user.user != null) {
        return Right(user);
      } else {
        return Left(UserNotFound());
      }
    } on UserNotFoundException catch (e) {
      return Left(UserNotFound());
    }
  }

  @override
  Future<Either<Failure, Student>> registerNewStudent(Student student) async {
    try {
      return Right((await remoteDataSource.addStudent(student)));
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      return Right(await remoteDataSource.logout());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getInitialUser();
      return Right(user);
    } on UserNotFoundException catch (e) {
      return Left(UserNotFound());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Usertype>> getUserType(User user) async {
    try {
      return Right(await remoteDataSource.getCurrentUserType(user));
    } on InvalidUserException catch (e) {
      return Left(InvalidUser());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }
}
