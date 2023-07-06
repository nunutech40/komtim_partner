import 'package:flutter/material.dart';
import 'package:komtim_partner/presentation/pages/auth/bloc/login_bloc.dart';
import 'package:komtim_partner/presentation/pages/auth/view/login_page.dart';
import 'package:komtim_partner/presentation/pages/auth/splash_screen.dart';
import 'package:komtim_partner/presentation/pages/home/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:komtim_partner/presentation/pages/home/main_page.dart';
import 'package:komtim_partner/presentation/router/app_router.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komtim_partner/DI/injection.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => di.locator<LoginBloc>(),
      child: MaterialApp.router(
        title: 'Komtim Partner',
        theme: ThemeData(
          textTheme: GoogleFonts.plusJakartaSansTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routeInformationProvider: AppRouter.router.routeInformationProvider,
        routeInformationParser: AppRouter.router.routeInformationParser,
        routerDelegate: AppRouter.router.routerDelegate,
      ),
    );
  }
}
