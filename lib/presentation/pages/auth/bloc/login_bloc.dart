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
  }

  Future<void> _handleLoginUsernameChangedEvent(
    LoginEmailChangedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(username: event.email, usernameErrorMessage: ''));
  }

  Future<void> _handleLoginPasswordChangedEvent(
    LoginPasswordChangedEvent event,
    Emitter<LoginState> emit,
  ) async {
    // Verify that the password is at least 8 characters long
    if (event.password.length < 8) {
      emit(state.copyWith(
        password: event.password,
        passwordErrorMessage: 'Password minimal 8 karakter',
      ));
      return;
    }

    // Verify that the password doesn't contain any whitespace
    if (event.password.contains(' ')) {
      emit(state.copyWith(
        password: event.password,
        passwordErrorMessage: 'Password tidak dapat menggunakan spasi',
      ));
      return;
    }

    // If the password passed all validation checks, update the state without an error message
    emit(state.copyWith(password: event.password, passwordErrorMessage: ''));
  }

  Future<void> _handleLoginWithUsernameAndPasswordEvent(
    LoginButtonPressedEvent event,
    Emitter<LoginState> emit,
  ) async {
    // Check if username or password is empty
    if (state.username.isEmpty || state.password.isEmpty) {
      emit(state.copyWith(
        status: RequestStatus.failure,
        usernameErrorMessage:
            state.username.isEmpty ? 'Username tidak boleh kosong' : '',
        passwordErrorMessage:
            state.password.isEmpty ? 'Password tidak boleh kosong' : '',
      ));
      return;
    }

    emit(state.copyWith(status: RequestStatus.loading));

    final result = await doLoginUseCase.execute(state.username, state.password);

    result.fold(
      (failure) {
        String newMessageError = failure.message;

        if (newMessageError == 'Invalid username or password' ||
            newMessageError.contains('Resource Not Found')) {
          newMessageError = 'Username atau password salah';
        } else {
          newMessageError =
              newMessageError.replaceFirst('Unexpected Error: ', '');
        }

        emit(state.copyWith(
          status: RequestStatus.failure,
          usernameErrorMessage: newMessageError,
          passwordErrorMessage: newMessageError,
        ));
      },
      (loginData) {
        emit(state.copyWith(message: 'Success', status: RequestStatus.success));
      },
    );
  }
}
