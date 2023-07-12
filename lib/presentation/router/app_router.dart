import 'package:flutter/material.dart';
import 'package:komtim_partner/data/datasources/preferences/shared_pref.dart';
import 'package:komtim_partner/presentation/pages/auth/bloc/forgot_password_bloc.dart';
import 'package:komtim_partner/presentation/pages/auth/bloc/login_bloc.dart';
import 'package:komtim_partner/presentation/pages/auth/view/forgot_password_page.dart';
import 'package:komtim_partner/presentation/pages/home/bloc/main_bloc.dart';
import 'package:komtim_partner/presentation/pages/home/view/profile_page.dart';
import 'package:komtim_partner/presentation/pages/not_found_page.dart';
import 'package:komtim_partner/presentation/pages/auth/view/login_page.dart';
import 'package:komtim_partner/presentation/pages/auth/splash_screen.dart';
import 'package:komtim_partner/presentation/pages/profile/bloc/profile_bloc.dart';
import 'package:komtim_partner/presentation/pages/profile/view/profile_info_update_page.dart';
import 'package:komtim_partner/presentation/router/router_utils.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komtim_partner/DI/injection.dart' as di;

import '../pages/home/view/main_page.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: PAGES.splash.screenPath,
    routes: [
      GoRoute(
        path: PAGES.splash.screenPath,
        name: PAGES.splash.screenName,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: PAGES.main.screenPath,
        name: PAGES.main.screenName,
        builder: (context, state) => BlocProvider(
          create: (context) => di.locator<MainBloc>(),
          child: const MainPage(),
        ),
      ),
      GoRoute(
          path: PAGES.login.screenPath,
          name: PAGES.login.screenName,
          builder: (context, state) => BlocProvider(
                create: (context) => di.locator<LoginBloc>(),
                child: const LoginPage(),
              )),
      GoRoute(
          path: PAGES.forgotPasswrod.screenPath,
          name: PAGES.forgotPasswrod.screenName,
          builder: (context, state) => BlocProvider(
                create: (context) => di.locator<ForgotPasswordBloc>(),
                child: const ForgotPasswordPage(),
              )),
      GoRoute(
        path: PAGES.profileInfo.screenPath,
        name: PAGES.profileInfo.screenName,
        builder: (context, state) => BlocProvider(
          create: (context) => di.locator<ProfileBloc>(),
          child: const ProfileInfoUpdatePage(),
        ),
      )
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );

  static GoRouter get router => _router;
}
