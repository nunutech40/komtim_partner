import 'package:flutter/material.dart';

import 'package:komtim_partner/common/styles.dart';
import '../../../router/app_router.dart';
import '../../../router/router_utils.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/custom_password_field.dart';
import '../bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          AppRouter.router.go(PAGES.home.screenPath);
        }
        if (state.status == LoginStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      child: const _LoginForm(),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _LoginHeader(),
                const SizedBox(height: 32.0),
                _LoginUsername(),
                const SizedBox(height: 24.0),
                _LoginPassword(),
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

class _LoginHeader extends StatelessWidget {
  const _LoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Login to',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
          textAlign: TextAlign.left,
        ),
        Text(
          'your Account',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}

class _LoginUsername extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: 'Username',
      hint: 'Masukkan username kamu',
      onChanged: (value) {
        context.read<LoginBloc>().add(LoginEmailChangedEvent(email: value));
      },
    );
  }
}

class _LoginPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPasswordField(
      label: 'Password',
      hint: 'Password kamu',
      onChanged: (value) {
        context
            .read<LoginBloc>()
            .add(LoginPasswordChangedEvent(password: value));
      },
    );
  }
}

class _ForgotPasswordText extends StatelessWidget {
  const _ForgotPasswordText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Lupa password?',
      style: TextStyle(
        fontSize: 12,
        color: primaryColor,
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        text: 'Login',
        onPressed: () {
          context.read<LoginBloc>().add(const LoginButtonPressedEvent());
        },
      ),
    );
  }
}
