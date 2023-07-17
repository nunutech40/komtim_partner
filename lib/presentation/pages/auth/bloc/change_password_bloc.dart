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
    on<StatusResetEvent>(_handleStatusResetEvent);
    on<ChangeNewPasswordChangedEvent>(_handleNewPassChangeEvent);
    on<ChangeOldPasswordChangedEvent>(_handleOldPassChangeEvent);
    on<ChangeConfirmPasswordChangedEvent>(_handleConfirmPassChangeEvent);
  }

  Future<void> _handleOldPassChangeEvent(
    ChangeOldPasswordChangedEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    var newState = state.copyWith(oldPassword: event.oldPass);
    print('cek _handleOldPassChangeEvent $newState');

    if (event.oldPass.length < 8) {
      newState = newState.copyWith(
        oldPassErrorMessage: 'Password minimal 8 karakter',
      );
    } else if (event.oldPass.contains(' ')) {
      newState = newState.copyWith(
        oldPassErrorMessage: 'Password tidak dapat menggunakan spasi',
      );
    } else {
      newState = newState.copyWith(
        oldPassErrorMessage: '',
      );
    }

    emit(newState);
  }

  Future<void> _handleNewPassChangeEvent(
    ChangeNewPasswordChangedEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    var newState = state.copyWith(newPassword: event.newPass);

    if (event.newPass.length < 8) {
      newState = newState.copyWith(
        newPassErrorMessage: 'Password minimal 8 karakter',
      );
    } else if (event.newPass.contains(' ')) {
      newState = newState.copyWith(
        newPassErrorMessage: 'Password tidak dapat menggunakan spasi',
      );
    } else {
      newState = newState.copyWith(
        newPassErrorMessage: '',
      );
    }

    emit(newState);
  }

  Future<void> _handleConfirmPassChangeEvent(
    ChangeConfirmPasswordChangedEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    var newState = state.copyWith(confirmPassword: event.confirmPass);

    if (event.confirmPass.length < 8) {
      newState = newState.copyWith(
        confirmPassErrorMessage: 'Password minimal 8 karakter',
      );
    } else if (event.confirmPass.contains(' ')) {
      newState = newState.copyWith(
        confirmPassErrorMessage: 'Password tidak dapat menggunakan spasi',
      );
    } else {
      newState = newState.copyWith(
        confirmPassErrorMessage: '',
      );
    }

    emit(newState);
  }

  Future<void> _handleStatusResetEvent(
    StatusResetEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(state.copyWith(
      status: RequestStatus.empty,
      newPassErrorMessage: '',
      oldPassErrorMessage: '',
      confirmPassErrorMessage: '',
    ));
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
        status: RequestStatus.empty,
        newPassErrorMessage:
            newPass.isEmpty ? 'Password baru tidak boleh kosong' : '',
        oldPassErrorMessage:
            oldPass.isEmpty ? 'Password lama tidak boleh kosong' : '',
        confirmPassErrorMessage:
            confirmPass.isEmpty ? 'Konfirmasi password tidak boleh kosong' : '',
      ));
      return;
    }

    emit(state.copyWith(status: RequestStatus.loading));

    final result =
        await changePasswordUseCase.execute(oldPass, newPass, confirmPass);

    result.fold(
      (failure) {
        String newMessageError = failure.message;

        if (newMessageError.contains('Invalid Old Password')) {
          newMessageError = 'Salah memasukan password lama kamu.';
          emit(state.copyWith(
            status: RequestStatus.empty,
            oldPassErrorMessage: newMessageError,
          ));
        } else if (newMessageError
            .contains('Confirmation Password did not match')) {
          newMessageError = 'Konfirmasi password yang kamu masukan salah.';
          emit(state.copyWith(
            status: RequestStatus.empty,
            confirmPassErrorMessage: newMessageError,
          ));
        } else {
          newMessageError =
              newMessageError.replaceFirst('Unexpected Error: ', '');
          emit(state.copyWith(
            status: RequestStatus.empty,
            newPassErrorMessage: newMessageError,
          ));
        }
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
