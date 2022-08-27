import 'package:aptcoder/features/login/data/datasources/remote/authentication_data_source.dart';
import 'package:aptcoder/features/login/data/repositories/authentication_repository_impl.dart';
import 'package:aptcoder/features/login/domain/repositories/authentication_repository.dart';
import 'package:aptcoder/features/login/domain/usecases/authentication_login_use_case.dart';
import 'package:aptcoder/features/login/presentation/bloc/authentication_bloc.dart';
import 'package:aptcoder/features/student_dashboard/data/datasources/student_remote_data_source.dart';
import 'package:aptcoder/features/student_dashboard/data/repositories/remote/student_repository_impl.dart';
import 'package:aptcoder/features/student_dashboard/domain/repositories/student_repository.dart';
import 'package:aptcoder/features/student_dashboard/domain/usecases/get_student_info.dart';
import 'package:aptcoder/features/student_dashboard/domain/usecases/get_student_last_courses.dart';
import 'package:aptcoder/features/student_dashboard/domain/usecases/view_course.dart';
import 'package:aptcoder/features/student_dashboard/presentation/bloc/student_dashboard_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

final sl = GetIt.instance;
void init() {
  sl.registerLazySingleton(() => AuthenticationBloc(sl()));
  sl.registerLazySingleton(() => AuthenticationLoginUseCase(sl()));
  sl.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl(sl()));
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(() => AuthenticationRemoteDataSourceImpl(sl(), sl(), sl()));
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => GoogleSignIn());
  sl.registerLazySingleton(() => Dio());

  sl.registerFactory(() => StudentDashboardBloc(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => GetStudentInfo(sl()));
  sl.registerLazySingleton(() => GetStudentLastCourses(sl()));
  sl.registerLazySingleton(() => ViewCourse(sl()));
  sl.registerLazySingleton<StudentRepository>(() => StudentRepositoryImpl(sl()));
  sl.registerLazySingleton<StudentRemoteDataSource>(() => StudentRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
