import 'package:flutter/material.dart';

import 'package:komtim_partner/common/styles.dart';
import 'package:komtim_partner/presentation/pages/auth/bloc/forgot_password_bloc.dart';
import 'package:komtim_partner/presentation/widgets/confirmation_dialog_oke.dart';
import '../../../../common/enum_status.dart';
import '../../../router/app_router.dart';
import '../../../router/router_utils.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext contexthere) {
    return Scaffold(
      body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state.status == RequestStatus.success) {
            showConfirmation(contexthere, context.read<ForgotPasswordBloc>());
          } else if (state.status == RequestStatus.failure) {
            if (!state.emailErrorMessage.contains('Email tidak ditemukan.')) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.emailErrorMessage),
                    backgroundColor: errorColor),
              );
              context.read<ForgotPasswordBloc>().add(SendStatusResetEvent());
            }
          }
        },
        child: const _ForgotPasswordForm(),
      ),
    );
  }

  static void showConfirmation(
      BuildContext context, ForgotPasswordBloc mainBloc) {
    ConfirmationDialogOke.show(
      context,
      onYesPressed: () {
        Navigator.of(context).pop();
        AppRouter.router.go(PAGES.login.screenPath);
      },
    );
  }
}

class _ForgotPasswordForm extends StatelessWidget {
  const _ForgotPasswordForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _ForgotPassHeader(),
                const SizedBox(height: 24.0),
                Text(
                  'Tautan untuk mengatur ulang password akan dikirim melalui email.',
                  style: AppTypography.regular12,
                ),
                const SizedBox(height: 32.0),
                _inputEmail(),
                const SizedBox(height: 24.0),
                const _ForgotPasswordText(),
                const SizedBox(height: 32.0),
                _SubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ForgotPassHeader extends StatelessWidget {
  const _ForgotPassHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lupa',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
          textAlign: TextAlign.left,
        ),
        Text(
          'Password',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}

class _inputEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, state) {
        return CustomTextField(
          label: 'Email',
          hint: 'email@gmail.com',
          errorText: state.emailErrorMessage.isNotEmpty
              ? state.emailErrorMessage
              : null,
          onChanged: (value) {
            context
                .read<ForgotPasswordBloc>()
                .add(ForgotEmailChangedEvent(email: value));
          },
        );
      },
    );
  }
}

class _ForgotPasswordText extends StatelessWidget {
  const _ForgotPasswordText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Ingat Password?',
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 2), // Add some spacing between the texts
        GestureDetector(
          onTap: () {
            AppRouter.router.pop();
          },
          child: const Text(
            'Kembali Masuk',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        )
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        text: 'Kirim',
        onPressed: () {
          context
              .read<ForgotPasswordBloc>()
              .add(const SendButtonPressedEvent());
        },
      ),
    );
  }
}
