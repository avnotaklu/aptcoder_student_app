import 'package:aptcoder/features/data/datasources/admin/admin_remote_data_source.dart';
import 'package:aptcoder/features/data/datasources/authentication/remote_authentication_data_source.dart';
import 'package:aptcoder/features/data/datasources/courses/remote_course_data_source.dart';
import 'package:aptcoder/features/data/datasources/student_dashboard/student_remote_data_source.dart';
import 'package:aptcoder/features/data/datasources/student_profile/profile_remote_data_source.dart';
import 'package:aptcoder/features/data/repositories/admin/admin_repostiroy_impl.dart';
import 'package:aptcoder/features/data/repositories/authentication/authentication_repository_impl.dart';
import 'package:aptcoder/features/data/repositories/courses/course_repository_impl.dart';
import 'package:aptcoder/features/data/repositories/student_dashboard/student_repository_impl.dart';
import 'package:aptcoder/features/data/repositories/student_profile/profile_repository_impl.dart';
import 'package:aptcoder/features/domain/repositories/admin/admin_repository.dart';
import 'package:aptcoder/features/domain/repositories/authentication/authentication_repository.dart';
import 'package:aptcoder/features/domain/repositories/courses/course_repository.dart';
import 'package:aptcoder/features/domain/repositories/student_dashboard/student_repository.dart';
import 'package:aptcoder/features/domain/repositories/student_profile/profile_repository.dart';
import 'package:aptcoder/features/domain/usecases/admin/add_course.dart';
import 'package:aptcoder/features/domain/usecases/admin/get_admin_info.dart';
import 'package:aptcoder/features/domain/usecases/authentication/add_student_info.dart';
import 'package:aptcoder/features/domain/usecases/authentication/authentication_login_use_case.dart';
import 'package:aptcoder/features/domain/usecases/authentication/autologin_usecase.dart';
import 'package:aptcoder/features/domain/usecases/authentication/logout_use_case.dart';
import 'package:aptcoder/features/domain/usecases/courses/get_all_courses_usecase.dart';
import 'package:aptcoder/features/domain/usecases/student_dashboard/get_student_info.dart';
import 'package:aptcoder/features/domain/usecases/student_dashboard/get_student_last_courses.dart';
import 'package:aptcoder/features/domain/usecases/student_dashboard/view_course.dart';
import 'package:aptcoder/features/domain/usecases/student_profile/update_profile_info.dart';
import 'package:aptcoder/features/presentation/pages/admin/admin_bloc.dart';
import 'package:aptcoder/features/presentation/pages/authentication/authentication_bloc.dart';
import 'package:aptcoder/features/presentation/pages/courses/courses_bloc.dart';
import 'package:aptcoder/features/presentation/pages/student_dashboard/student_dashboard_bloc.dart';
import 'package:aptcoder/features/presentation/pages/student_profile/student_profile_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

final sl = GetIt.instance;
void init() {
  // Global dependencies
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => GoogleSignIn());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);

  // Feature wise dependencies
  sl.registerLazySingleton(() => AuthenticationBloc(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => AuthenticationLoginUseCase(sl()));
  sl.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl(sl()));
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(() => AuthenticationRemoteDataSourceImpl(sl(), sl(), sl()));
  sl.registerLazySingleton(() => AddStudentInfo(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => AutoLoginUseCase(sl()));

  sl.registerLazySingleton(() => AdminBloc(sl(), sl(), sl()));
  sl.registerLazySingleton(() => GetAdminInfo(sl()));
  sl.registerLazySingleton(() => AddCourse(sl()));
  sl.registerLazySingleton<AdminRepository>(() => AdminRepositoryImpl(sl()));
  sl.registerLazySingleton<AdminRemoteDataSource>(() => AdminRemoteDataSourceImpl(sl(), sl()));

  sl.registerLazySingleton(() => CoursesBloc(sl()));
  sl.registerLazySingleton(() => GetAllCourses(sl()));
  sl.registerLazySingleton<CourseRepository>(() => CourseRepositoryImpl(sl()));
  sl.registerLazySingleton<RemoteCourseDataSource>(() => RemoteCourseDataSourceImpl(sl()));

  sl.registerLazySingleton(() => StudentDashboardBloc(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => GetStudentInfo(sl()));
  sl.registerLazySingleton(() => GetStudentLastCourses(sl()));
  sl.registerLazySingleton(() => ViewCourse(sl()));
  sl.registerLazySingleton<StudentRepository>(() => StudentRepositoryImpl(sl()));
  sl.registerLazySingleton<StudentRemoteDataSource>(() => StudentRemoteDataSourceImpl(sl()));

  sl.registerLazySingleton(() => StudentProfileBloc(sl(), sl()));
  sl.registerLazySingleton(() => UpdateProfileInfo(sl()));
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(sl()));
  sl.registerLazySingleton<ProfileRemoteDataSource>(() => ProfileRemoteDataSourceImpl(sl(), sl()));
}
