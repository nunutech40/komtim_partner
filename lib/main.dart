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

import 'DI/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: di.locator.allReady(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
              home: Scaffold(body: Center(child: CircularProgressIndicator())));
        } else {
          return MaterialApp.router(
            title: 'Komtim Partner',
            theme: ThemeData(
              textTheme: GoogleFonts.plusJakartaSansTextTheme(),
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            routeInformationProvider: AppRouter.router.routeInformationProvider,
            routeInformationParser: AppRouter.router.routeInformationParser,
            routerDelegate: AppRouter.router.routerDelegate,
          );
        }
      },
    );
  }
}
