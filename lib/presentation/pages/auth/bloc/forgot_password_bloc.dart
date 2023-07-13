import 'package:equatable/equatable.dart';
import 'package:komtim_partner/domain/usecases/send_forgot_password_use_case.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import '../../../../common/enum_status.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final SendForgotPasswordUseCase sendForgotPasswordUseCase;

  ForgotPasswordBloc({required this.sendForgotPasswordUseCase})
      : super(const ForgotPasswordState()) {
    on<SendButtonPressedEvent>(_handleSendForgotPassword);
    on<SendStatusResetEvent>(_handleStatusResetEvent);
    on<ForgotEmailChangedEvent>(_handleEmailNameChangeEvent);
  }

  Future<void> _handleEmailNameChangeEvent(
    ForgotEmailChangedEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    final email = event.email;

    if (email.isEmpty) {
      emit(state.copyWith(
        email: email,
        emailErrorMessage: 'Email tidak boleh kosong',
      ));
      return;
    }

    final emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,})$');
    if (!emailRegex.hasMatch(email)) {
      emit(state.copyWith(
        email: email,
        emailErrorMessage: 'Format email tidak valid',
      ));
      return;
    }

    emit(state.copyWith(email: email, emailErrorMessage: ''));
  }

  Future<void> _handleStatusResetEvent(
    SendStatusResetEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(state.copyWith(
      status: RequestStatus.empty,
      emailErrorMessage: '',
    ));
  }

  Future<void> _handleSendForgotPassword(
    SendButtonPressedEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    final email = state.email;

    if (email.isEmpty) {
      emit(state.copyWith(
        emailErrorMessage: 'Email tidak boleh kosong',
      ));
      return;
    }

    emit(state.copyWith(status: RequestStatus.loading));

    final result = await sendForgotPasswordUseCase.execute(state.email);

    result.fold(
      (failure) {
        String newMessageError = failure.message;

        if (newMessageError.contains('Email Not Found')) {
          newMessageError = 'Email tidak ditemukan.';
        } else {
          newMessageError =
              newMessageError.replaceFirst('Unexpected Error: ', '');
        }

        emit(state.copyWith(
          status: RequestStatus.empty,
          emailErrorMessage: newMessageError,
        ));
      },
      (forgotPassword) {
        emit(state.copyWith(
          message: 'Success',
          status: RequestStatus.success,
        ));
      },
    );
  }
}
