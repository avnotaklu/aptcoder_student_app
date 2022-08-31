import 'package:aptcoder/features/domain/entities/authentication/user.dart';
import 'package:aptcoder/features/presentation/pages/admin/admin_bloc.dart';
import 'package:aptcoder/features/presentation/pages/admin/admin_panel.dart';
import 'package:aptcoder/features/presentation/pages/authentication/authentication_bloc.dart';
import 'package:aptcoder/features/presentation/pages/authentication/student_login.dart';
import 'package:aptcoder/features/presentation/pages/student_dashboard/homepage.dart';
import 'package:aptcoder/features/presentation/pages/student_dashboard/student_dashboard_bloc.dart';
import 'package:aptcoder/firebase_options.dart';
import 'package:aptcoder/injection_container.dart';
import 'package:aptcoder/core/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(BlocProvider<AuthenticationBloc>(
      lazy: false, create: (context) => sl<AuthenticationBloc>()..add(InitialAuthCheckEvent()), child: MyApp()));
}

class MyApp extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Aptcoder',
      theme: ThemeData(
          fontFamily: 'Ubuntu',
          primaryColor: secondaryColor,
          textTheme: const TextTheme(
            headlineLarge: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
            headlineMedium: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic),
            headlineSmall: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
            titleLarge: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
            titleMedium: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
            titleSmall: TextStyle(
              fontSize: 14.0,
            ),
            labelLarge: TextStyle(
              fontSize: 16.0,
              fontStyle: FontStyle.italic,
            ),
            labelMedium: TextStyle(
              fontSize: 14.0,
              fontStyle: FontStyle.italic,
            ),
            labelSmall: TextStyle(
              fontSize: 12.0,
              fontStyle: FontStyle.italic,
            ),
          ),
          elevatedButtonTheme:
              ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(primaryColor)))),
      home: const StudentLoginPage(),
      builder: ((context, child) => BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: ((context, state) => {
                if (state is LogoutState)
                  {
                    _navigator.pushAndRemoveUntil(
                        MaterialPageRoute(builder: ((context) => const StudentLoginPage())), (route) => false)
                  }
                else if (state is AuthorizedState)
                  {
                    if (state.user.type == Usertype.student)
                      {
                        _navigator.pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: ((newContext) => MultiBlocProvider(providers: [
                                      BlocProvider(
                                        create: (newContext) => sl<StudentDashboardBloc>()..add(FetchStudentEvent()),
                                      ),
                                      BlocProvider(
                                        create: (newContext) => sl<AuthenticationBloc>(),
                                      )
                                    ], child: const HomePage()))),
                            (route) => false)
                      }
                    else
                      {
                        _navigator.pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: ((context) => MultiBlocProvider(
                                        providers: [
                                          BlocProvider(create: (newContext) => sl<AdminBloc>()..add(FetchAdminEvent())),
                                          BlocProvider(
                                            create: (newContext) => sl<AuthenticationBloc>(),
                                          )
                                        ], child: const AdminPanel()))),
                            (route) => false)
                      }
                  }
              }),
          child: child)),
      onGenerateRoute: (_) => MaterialPageRoute(builder: ((context) => const StudentLoginPage())),
      debugShowCheckedModeBanner: false,
    );
  }
}
