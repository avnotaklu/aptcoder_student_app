import 'package:aptcoder/features/admin/data/datasources/admin_remote_data_source.dart';
import 'package:aptcoder/features/admin/data/repositories/admin_repostiroy_impl.dart';
import 'package:aptcoder/features/admin/domain/repositories/admin_repository.dart';
import 'package:aptcoder/features/admin/domain/usecases/add_course.dart';
import 'package:aptcoder/features/admin/domain/usecases/get_admin_info.dart';
import 'package:aptcoder/features/admin/presentation/bloc/admin_bloc.dart';
import 'package:aptcoder/features/courses/data/datasources/remote_course_data_source.dart';
import 'package:aptcoder/features/courses/data/repositories/course_repository_impl.dart';
import 'package:aptcoder/features/courses/domain/repositories/course_repository.dart';
import 'package:aptcoder/features/courses/domain/usecases/get_all_courses_usecase.dart';
import 'package:aptcoder/features/courses/presentation/bloc/courses_bloc.dart';
import 'package:aptcoder/features/login/data/datasources/remote/authentication_data_source.dart';
import 'package:aptcoder/features/login/data/repositories/authentication_repository_impl.dart';
import 'package:aptcoder/features/login/domain/repositories/authentication_repository.dart';
import 'package:aptcoder/features/login/domain/usecases/add_student_info.dart';
import 'package:aptcoder/features/login/domain/usecases/authentication_login_use_case.dart';
import 'package:aptcoder/features/login/domain/usecases/autologin_usecase.dart';
import 'package:aptcoder/features/login/domain/usecases/logout_use_case.dart';
import 'package:aptcoder/features/login/presentation/bloc/authentication_bloc.dart';
import 'package:aptcoder/features/student_dashboard/data/datasources/student_remote_data_source.dart';
import 'package:aptcoder/features/student_dashboard/data/repositories/remote/student_repository_impl.dart';
import 'package:aptcoder/features/student_dashboard/domain/repositories/student_repository.dart';
import 'package:aptcoder/features/student_dashboard/domain/usecases/get_student_info.dart';
import 'package:aptcoder/features/student_dashboard/domain/usecases/get_student_last_courses.dart';
import 'package:aptcoder/features/student_dashboard/domain/usecases/view_course.dart';
import 'package:aptcoder/features/student_dashboard/presentation/bloc/student_dashboard_bloc.dart';
import 'package:aptcoder/features/student_profile/data/datasources/profile_remote_data_source.dart';
import 'package:aptcoder/features/student_profile/data/repositories/profile_repository_impl.dart';
import 'package:aptcoder/features/student_profile/domain/repositories/profile_repository.dart';
import 'package:aptcoder/features/student_profile/domain/usecases/update_profile_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

final sl = GetIt.instance;
void init() {
  sl.registerLazySingleton(() => AuthenticationLoginUseCase(sl()));
  sl.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl(sl()));
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(() => AuthenticationRemoteDataSourceImpl(sl(), sl(), sl()));
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => GoogleSignIn());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => AddStudentInfo(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => AutoLoginUseCase(sl()));

  sl.registerLazySingleton(() => GetStudentInfo(sl()));
  sl.registerLazySingleton(() => GetStudentLastCourses(sl()));
  sl.registerLazySingleton(() => ViewCourse(sl()));
  sl.registerLazySingleton<StudentRepository>(() => StudentRepositoryImpl(sl()));
  sl.registerLazySingleton<StudentRemoteDataSource>(() => StudentRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => GetAdminInfo(sl()));
  sl.registerLazySingleton(() => AddCourse(sl()));
  sl.registerLazySingleton<AdminRepository>(() => AdminRepositoryImpl(sl()));
  sl.registerLazySingleton<AdminRemoteDataSource>(() => AdminRemoteDataSourceImpl(sl(), sl()));
  sl.registerLazySingleton(() => FirebaseStorage.instance);

  sl.registerLazySingleton(() => GetAllCourses(sl()));
  sl.registerLazySingleton<CourseRepository>(() => CourseRepositoryImpl(sl()));
  sl.registerLazySingleton<RemoteCourseDataSource>(() => RemoteCourseDataSourceImpl(sl()));

  sl.registerLazySingleton(() => UpdateProfileInfo(sl()));
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(sl()));
  sl.registerLazySingleton<ProfileRemoteDataSource>(() => ProfileRemoteDataSourceImpl(sl(), sl()));
}
