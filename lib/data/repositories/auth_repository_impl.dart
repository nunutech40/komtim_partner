import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:komtim_partner/common/failure.dart';
import 'package:komtim_partner/data/datasources/preferences/shared_pref.dart';
import 'package:komtim_partner/data/datasources/remote/auth_remote_datasource.dart';
import 'package:komtim_partner/data/models/login_response.dart';
import 'package:komtim_partner/domain/entities/login_model.dart';
import 'package:komtim_partner/domain/repositories/auth_repository.dart';

import '../../common/exception.dart';
import 'base_repository.dart';

class AuthRepositoryImpl with RepositoryMixin implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SharedPref sharedPref;

  AuthRepositoryImpl(
      {required this.remoteDataSource, required this.sharedPref});

  @override
  Future<Either<Failure, T>> executeEither<T>(Future<T> Function() f) async {
    try {
      final result = await f();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException catch (e) {
      return Left(
          ConnectionFailure('Failed to connect to the network: ${e.message}'));
    } catch (e) {
      return Left(UnknownFailure('Unexpected Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> getAuthState() async {
    return executeEither(() async {
      return await sharedPref.isLoggedIn();
    });
  }

  @override
  Future<Either<Failure, LoginModel>> doLogin(
      String username, String password) async {
    return executeEither(() async {
      final result = await remoteDataSource.doLogin(username, password);
      sharedPref.saveUserAndToken(LoginResponse(
          accessToken: result.accessToken,
          tokenType: result.tokenType,
          data: result.data));
      return result.toEntity();
    });
  }

  @override
  Future<Either<Failure, bool>> doLogout() async {
    return executeEither(() async {
      sharedPref.removeDataPref();
      final result = await remoteDataSource.doLogout();
      if (result) {
        sharedPref.removeDataPref();
      }
      return result;
    });
  }
}
