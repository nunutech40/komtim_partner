import 'package:flutter/material.dart';
import 'package:komtim_partner/data/datasources/preferences/shared_pref.dart';
import 'package:komtim_partner/presentation/pages/auth/bloc/login_bloc.dart';
import 'package:komtim_partner/presentation/pages/home/bloc/main_bloc.dart';
import 'package:komtim_partner/presentation/pages/not_found_page.dart';
import 'package:komtim_partner/presentation/pages/auth/view/login_page.dart';
import 'package:komtim_partner/presentation/pages/auth/splash_screen.dart';
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
    redirect: (context, state) async {
      final pref = di.locator<SharedPref>();
      if (await pref.isLoggedIn()) {
        if (state.location == PAGES.splash.screenPath) {
          return PAGES.main.screenPath;
        }
        return null;
      } else {
        return PAGES.login.screenPath;
      }
    },
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
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );

  static GoRouter get router => _router;
}
