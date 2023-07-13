import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komtim_partner/presentation/pages/auth/bloc/change_password_bloc.dart';
import '../../../../common/enum_status.dart';
import '../../../../common/styles.dart';
import '../../../router/app_router.dart';
import '../../../router/router_utils.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_password_field.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Password'),
      ),
      body: BlocListener<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state.status == RequestStatus.success) {
            AppRouter.router.go(PAGES.login.screenPath);
          } else if (state.status == RequestStatus.failure) {
            if (state.newPassErrorMessage.isNotEmpty &&
                !state.newPassErrorMessage
                    .contains('Konfirmasi password yang kamu masukan salah.') &&
                !state.newPassErrorMessage
                    .contains('Salah memasukan password lama kamu.')) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.newPassErrorMessage),
                    backgroundColor: errorColor),
              );
              context.read<ChangePasswordBloc>().add(StatusResetEvent());
            }

            if (state.oldPassErrorMessage.isNotEmpty &&
                !state.oldPassErrorMessage
                    .contains('Konfirmasi password yang kamu masukan salah.') &&
                !state.oldPassErrorMessage
                    .contains('Salah memasukan password lama kamu.')) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.oldPassErrorMessage),
                    backgroundColor: errorColor),
              );
              context.read<ChangePasswordBloc>().add(StatusResetEvent());
            }

            if (state.confirmPassErrorMessage.isNotEmpty &&
                !state.confirmPassErrorMessage
                    .contains('Konfirmasi password yang kamu masukan salah.') &&
                !state.confirmPassErrorMessage
                    .contains('Salah memasukan password lama kamu.')) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.confirmPassErrorMessage),
                    backgroundColor: errorColor),
              );
              context.read<ChangePasswordBloc>().add(StatusResetEvent());
            }
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      _OldPassword(),
                      const SizedBox(height: 24.0),
                      _NewPassword(),
                      const SizedBox(height: 24.0),
                      _ConfirmPassword(),
                      const SizedBox(height: 24.0),
                    ],
                  ),
                  _SubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NewPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      builder: (context, state) {
        return CustomPasswordField(
          label: 'Password Baru',
          hint: '',
          errorText: state.newPassErrorMessage.isNotEmpty
              ? state.newPassErrorMessage
              : null,
          onChanged: (value) {
            print('cek valueenya: $value');
            context
                .read<ChangePasswordBloc>()
                .add(ChangeNewPasswordChangedEvent(newPass: value));
          },
        );
      },
    );
  }
}

class _OldPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      builder: (context, state) {
        return CustomPasswordField(
          label: 'Password Lama',
          hint: '',
          errorText: state.oldPassErrorMessage.isNotEmpty
              ? state.oldPassErrorMessage
              : null,
          onChanged: (value) {
            context
                .read<ChangePasswordBloc>()
                .add(ChangeOldPasswordChangedEvent(oldPass: value));
          },
        );
      },
    );
  }
}

class _ConfirmPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      builder: (context, state) {
        return CustomPasswordField(
          label: 'Konfirmasi Password Baru',
          hint: '',
          errorText: state.confirmPassErrorMessage.isNotEmpty
              ? state.confirmPassErrorMessage
              : null,
          onChanged: (value) {
            context
                .read<ChangePasswordBloc>()
                .add(ChangeConfirmPasswordChangedEvent(confirmPass: value));
          },
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        text: 'Simpan',
        onPressed: () {
          context
              .read<ChangePasswordBloc>()
              .add(const ChangePassButtonPressedEvent());
        },
      ),
    );
  }
}
