import 'package:flutter/material.dart';
import 'package:komtim_partner/presentation/not_found_page.dart';
import 'package:komtim_partner/presentation/pages/auth/login_page.dart';
import 'package:komtim_partner/presentation/pages/auth/splash_screen.dart';
import 'package:komtim_partner/presentation/pages/home/home_page.dart';
import 'package:komtim_partner/presentation/pages/home/main_page.dart';
import 'package:komtim_partner/presentation/router/router_utils.dart';
import 'package:go_router/go_router.dart';

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
        path: PAGES.home.screenPath,
        name: PAGES.home.screenName,
        builder: (context, state) => const MainPage(),
      ),
      GoRoute(
        path: PAGES.login.screenPath,
        name: PAGES.login.screenName,
        builder: (context, state) => const LoginPage(),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );

  static GoRouter get router => _router;
}
