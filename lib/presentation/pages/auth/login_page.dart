import 'package:flutter/material.dart';
import 'package:komtim_partner/common/styles.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../router/app_router.dart';
import '../../router/router_utils.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_password_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // main axis ini vertical
              crossAxisAlignment:
                  CrossAxisAlignment.start, // cross axis ini horizontal
              children: [
                const Text(
                  'Login to',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
                  textAlign: TextAlign.left,
                ),
                const Text(
                  'your Account',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 32.0,
                ),
                const CustomTextField(
                  label: 'Username',
                  hint: 'Masukkan username kamu',
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const CustomPasswordField(
                  label: 'Password',
                  hint: 'Password kamu',
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Text(
                  'Lupa password?',
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(
                  height: 32.0,
                ),
                SizedBox(
                  width:
                      double.infinity, // Set width to fill the available space
                  child: CustomButton(
                    text: 'Login',
                    onPressed: () {
                      AppRouter.router.go(PAGES.home.screenPath);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
