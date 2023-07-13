import 'package:equatable/equatable.dart';
import 'package:komtim_partner/domain/usecases/change_password_use_case.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import '../../../../common/enum_status.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordUseCase changePasswordUseCase;

  ChangePasswordBloc({required this.changePasswordUseCase})
      : super(const ChangePasswordState()) {
    on<ChangePassButtonPressedEvent>(_handleChangePasswordSubmit);
    on<SendStatusResetEvent>(_handleStatusResetEvent);
    on<ChangeNewPasswordChangedEvent>(_handleNewPassChangeEvent);
    on<ChangeOldPasswordChangedEvent>(_handleOldPassChangeEvent);
    on<ChangeConfirmPasswordChangedEvent>(_handleConfirmPassChangeEvent);
  }

  Future<void> _handleNewPassChangeEvent(
    ChangeNewPasswordChangedEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    if (event.newPass.length < 8) {
      emit(state.copyWith(
        newPassword: event.newPass,
        newPassErrorMessage: 'Password minimal 8 karakter',
      ));
      return;
    }

    // Verify that the password doesn't contain any whitespace
    if (event.newPass.contains(' ')) {
      emit(state.copyWith(
        newPassword: event.newPass,
        newPassErrorMessage: 'Password tidak dapat menggunakan spasi',
      ));
      return;
    }

    emit(state.copyWith(newPassword: event.newPass, newPassErrorMessage: ''));
  }

  Future<void> _handleOldPassChangeEvent(
    ChangeOldPasswordChangedEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    if (event.oldPass.length < 8) {
      emit(state.copyWith(
        oldPassword: event.oldPass,
        oldPassErrorMessage: 'Password minimal 8 karakter',
      ));
      return;
    }
    if (event.oldPass.contains(' ')) {
      emit(state.copyWith(
        oldPassword: event.oldPass,
        oldPassErrorMessage: 'Password tidak dapat menggunakan spasi',
      ));
      return;
    }
    emit(state.copyWith(oldPassword: event.oldPass, oldPassErrorMessage: ''));
  }

  Future<void> _handleConfirmPassChangeEvent(
    ChangeConfirmPasswordChangedEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    if (event.confirmPass.length < 8) {
      emit(state.copyWith(
        confirmPassword: event.confirmPass,
        confirmPassErrorMessage: 'Password minimal 8 karakter',
      ));
      return;
    }

    if (event.confirmPass.contains(' ')) {
      emit(state.copyWith(
        confirmPassword: event.confirmPass,
        confirmPassErrorMessage: 'Password tidak dapat menggunakan spasi',
      ));
      return;
    }

    emit(state.copyWith(
        confirmPassword: event.confirmPass, confirmPassErrorMessage: ''));
  }

  Future<void> _handleStatusResetEvent(
    SendStatusResetEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(state.copyWith(
        status: RequestStatus.empty,
        newPassErrorMessage: '',
        oldPassErrorMessage: '',
        confirmPassErrorMessage: ''));
  }

  Future<void> _handleChangePasswordSubmit(
    ChangePassButtonPressedEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    final newPass = state.newPassword;
    final oldPass = state.oldPassword;
    final confirmPass = state.confirmPassword;

    if (newPass.isEmpty || oldPass.isEmpty || confirmPass.isEmpty) {
      emit(state.copyWith(
        status: RequestStatus.failure,
        newPassErrorMessage:
            newPass.isEmpty ? 'Password baru tidak boleh kosong ' : '',
        oldPassErrorMessage:
            oldPass.isEmpty ? 'Password lama tidak boleh kosong' : '',
        confirmPassErrorMessage: confirmPass.isEmpty
            ? 'Confirmation password baru tidak boleh kosong'
            : '',
      ));
      return;
    }

    emit(state.copyWith(status: RequestStatus.loading));

    final result =
        await changePasswordUseCase.execute(newPass, oldPass, confirmPass);

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: RequestStatus.empty,
          newPassErrorMessage: failure.message,
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
