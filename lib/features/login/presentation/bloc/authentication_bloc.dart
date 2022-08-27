import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/features/login/data/repositories/authentication_repository_impl.dart';
import 'package:aptcoder/features/login/domain/core/failure.dart';
import 'package:aptcoder/features/login/domain/entities/user.dart';
import 'package:aptcoder/features/login/domain/usecases/authentication_login_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/empty_params.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationLoginUseCase authenticationLoginUseCase;
  AuthenticationBloc(this.authenticationLoginUseCase) : super(AuthenticationInitialState()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is LoginEvent) {
        final result = await authenticationLoginUseCase.call(AuthenticationParams(event.type));
        result.fold((l) => emit(UnAuthorizedState(_mapLoginFailureToMessage(l))), (r) => emit(AuthorizedState(r)));
      }
      if (event is LoginRequestEvent) {
        add(LoginEvent(event.type));
        emit(LoginProgressState());
      }
      if (event is InitialAuthCheckEvent) {
        // TODO: implement auto login at start
        emit(AuthorizationPromptState());
      }
    });
  }

  String _mapLoginFailureToMessage(Failure failure) {
    if (failure is UserNotFound) {
      return "No user was found";
    } else if (failure is InvalidUser) {
      return "This google user is invalid";
    } else {
      assert(failure is UnexpectedFailure);
      return "No user was found";
    }
  }
}
