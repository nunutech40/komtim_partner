import 'package:equatable/equatable.dart';
import 'package:komtim_partner/domain/usecases/do_login.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import '../../../../common/enum_status.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DoLoginUseCase doLoginUseCase;

  LoginBloc({
    required this.doLoginUseCase,
  }) : super(const LoginState()) {
    on<LoginButtonPressedEvent>(_handleLoginWithUsernameAndPasswordEvent);
    on<LoginEmailChangedEvent>(_handleLoginUsernameChangedEvent);
    on<LoginPasswordChangedEvent>(_handleLoginPasswordChangedEvent);
    on<EmptyEvent>(_handleAfterError);
  }

  Future<void> _handleAfterError(
    EmptyEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.empty));
  }

  Future<void> _handleLoginUsernameChangedEvent(
    LoginEmailChangedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(username: event.email));
  }

  Future<void> _handleLoginPasswordChangedEvent(
    LoginPasswordChangedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _handleLoginWithUsernameAndPasswordEvent(
    LoginButtonPressedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading));

    final result = await doLoginUseCase.execute(state.username, state.password);

    result.fold(
      (failure) {
        emit(state.copyWith(
            message: failure.message, status: RequestStatus.failure));
      },
      (loginData) {
        emit(state.copyWith(message: 'Success', status: RequestStatus.success));
      },
    );
  }
}
