import 'package:flutter/material.dart';
import 'package:komtim_partner/presentation/router/app_router.dart';

import '../../../data/datasources/preferences/shared_pref.dart';

import 'package:komtim_partner/di/injection.dart' as di;

import '../../router/router_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    // Use your dependency injection method to get the SharedPref instance.
    final pref = di.locator<SharedPref>();

    // wait for the splash screen duration
    await Future.delayed(const Duration(seconds: 2));

    if (await pref.isLoggedIn()) {
      AppRouter.router.go(PAGES.main.screenPath);
    } else {
      AppRouter.router.go(PAGES.login.screenPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/komtim.png'),
      ),
    );
  }
}
