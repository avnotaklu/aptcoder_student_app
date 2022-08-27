import 'package:aptcoder/core/error/app_exception.dart';
import 'package:aptcoder/features/login/domain/entities/user.dart';
import 'package:aptcoder/service/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthenticationRemoteDataSource {
  Future<UserCredential> login();
  Future<Usertype> getUserType(creds);
}

class AuthenticationRemoteDataSourceImpl implements AuthenticationRemoteDataSource {
  final Dio client;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthenticationRemoteDataSourceImpl(this.client, this._auth, this._googleSignIn);
  @override
  Future<UserCredential> login() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      // TODO: write custom exceptions
      throw UserNotFoundException();
    }
  }

  @override
  Future<Usertype> getUserType(creds) async {
    if (creds.user != null) {
      if (((await db.collection('admins').doc(creds.user!.uid).get())).exists) {
        return Usertype.admin;
      } else if ((await db.collection('students').doc(creds.user!.uid).get()).exists) {
        return Usertype.student;
      }
    }
    throw UserNotFoundException();
  }
}

class UserNotFoundException extends AppException {}

class UnexpectedException extends AppException {}
