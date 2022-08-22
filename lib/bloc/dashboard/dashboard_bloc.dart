import 'package:aptcoder/bloc/authentication/authentication_bloc.dart';
import 'package:aptcoder/data/student_profile_service.dart';
import 'package:aptcoder/model/student.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    
  }
}
