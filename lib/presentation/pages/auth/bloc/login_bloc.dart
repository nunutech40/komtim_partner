import 'package:equatable/equatable.dart';
import 'package:komtim_partner/domain/usecases/do_login.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.doLoginUseCase,
  }) : super(const LoginState()) {
    on<LoginButtonPressedEvent>(_handleLoginWithUsernameAndPasswordEvent);
    on<LoginEmailChangedEvent>(_handleLoginUsernameChangedEvent);
    on<LoginPasswordChangedEvent>(_handleLoginPasswordChangedEvent);
  }

  final DoLoginUseCase doLoginUseCase;

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
    emit(state.copyWith(status: LoginStatus.loading));

    final result = await doLoginUseCase.execute(
      state.username,
      state.password,
      state.loginFrom,
      state.fcmToken,
    );


    result.fold(
      (failure) {
        emit(state.copyWith(
            message: failure.message, status: LoginStatus.failure));
      },
      (loginData) {
        emit(state.copyWith(message: 'Success', status: LoginStatus.success));
      },
    );
  }
}
