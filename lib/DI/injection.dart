import 'package:get_it/get_it.dart';
import 'package:komtim_partner/data/datasources/remote/auth_remote_datasource.dart';
import 'package:komtim_partner/data/repositories/auth_repository_impl.dart';
import 'package:komtim_partner/domain/repositories/auth_repository.dart';
import 'package:komtim_partner/domain/usecases/do_login.dart';
import 'package:komtim_partner/presentation/pages/auth/bloc/login_bloc.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  // inject bloc
  locator.registerFactory(() => LoginBloc(doLoginUseCase: locator()));

  // inject usecase
  locator.registerLazySingleton(() => DoLoginUseCase(locator()));

  // inject repository
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: locator()));

  // inject datasource
  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
}
