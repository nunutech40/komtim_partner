import 'package:get_it/get_it.dart';
import 'package:komtim_partner/data/datasources/preferences/shared_pref.dart';
import 'package:komtim_partner/data/datasources/remote/auth_remote_datasource.dart';
import 'package:komtim_partner/data/datasources/remote/profile_remote_datasource.dart';
import 'package:komtim_partner/data/repositories/auth_repository_impl.dart';
import 'package:komtim_partner/data/repositories/profile_repository_impl.dart';
import 'package:komtim_partner/domain/repositories/auth_repository.dart';
import 'package:komtim_partner/domain/repositories/profile_repository.dart';
import 'package:komtim_partner/domain/usecases/change_password_use_case.dart';
import 'package:komtim_partner/domain/usecases/do_login_use_case.dart';
import 'package:komtim_partner/domain/usecases/do_logout_use_case.dart';
import 'package:komtim_partner/domain/usecases/get_auth_state_use_case.dart';
import 'package:komtim_partner/domain/usecases/get_profile_use_case.dart';
import 'package:komtim_partner/domain/usecases/send_forgot_password_use_case.dart';
import 'package:komtim_partner/presentation/pages/auth/bloc/change_password_bloc.dart';
import 'package:komtim_partner/presentation/pages/auth/bloc/forgot_password_bloc.dart';
import 'package:komtim_partner/presentation/pages/auth/bloc/login_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:komtim_partner/presentation/pages/home/bloc/main_bloc.dart';
import 'package:komtim_partner/presentation/pages/profile/bloc/profile_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/apiservice/http_service.dart';
import '../data/apiservice/response_parser.dart';

final locator = GetIt.instance;

Future<void> initDependencies() async {
  // inject bloc
  locator.registerFactory(() => LoginBloc(doLoginUseCase: locator()));
  locator.registerFactory(
      () => MainBloc(doLogoutUseCase: locator(), getProfileUseCase: locator()));
  locator.registerFactory(() => ProfileBloc(getProfileUseCase: locator()));
  locator.registerFactory(
      () => ForgotPasswordBloc(sendForgotPasswordUseCase: locator()));
  locator.registerFactory(
      () => ChangePasswordBloc(changePasswordUseCase: locator()));

  // inject usecase
  locator.registerLazySingleton(() => DoLoginUseCase(locator(), locator()));
  locator.registerLazySingleton(() => GetAuthStateUseCase(locator()));
  locator.registerLazySingleton(() => DoLogoutUseCase(locator()));
  locator.registerLazySingleton(() => GetProfileUseCase(locator()));
  locator.registerLazySingleton(() => SendForgotPasswordUseCase(locator()));
  locator.registerLazySingleton(() => ChangePasswordUseCase(locator()));

  // inject repository
  locator.registerLazySingleton<AuthRepository>(() =>
      AuthRepositoryImpl(remoteDataSource: locator(), sharedPref: locator()));
  locator.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(
      remoteDataSource: locator(), sharedPref: locator()));

  // inject datasource
  locator.registerLazySingleton<AuthRemoteDataSource>(() =>
      AuthRemoteDataSourceImpl(client: locator(), responseParser: locator()));
  locator.registerLazySingleton<ProfileRemoteDataSource>(() =>
      ProfileRemoteDataSourceImpl(
          client: locator(), responseParser: locator()));

  // Register SharedPreferences
  locator.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());

// Register SharedPref
  locator.registerLazySingleton<SharedPref>(() =>
      SharedPref(sharedPreferences: locator.getAsync<SharedPreferences>()));

  // external
  locator.registerLazySingleton(() => http.Client());

  // http service
  locator.registerLazySingleton(
      () => HttpService(client: locator(), sharedPref: locator()));
  locator.registerLazySingleton(() => ResponseParser());

  // Ensure SharedPreferences is ready
  await locator.allReady();
}
