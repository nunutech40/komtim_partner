import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:komtim_partner/common/failure.dart';
import 'package:komtim_partner/data/datasources/preferences/shared_pref.dart';
import 'package:komtim_partner/data/datasources/remote/auth_remote_datasource.dart';
import 'package:komtim_partner/data/models/login_response.dart';
import 'package:komtim_partner/domain/entities/login_model.dart';
import 'package:komtim_partner/domain/repositories/auth_repository.dart';

import 'base_repository.dart';

class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SharedPref sharedPref;

  AuthRepositoryImpl(
      {required this.remoteDataSource, required this.sharedPref});

  @override
  Future<Either<Failure, bool>> getAuthState() async {
    return executeEitherPref(() async {
      return await sharedPref.isLoggedIn();
    });
  }

  @override
  Future<Either<Failure, LoginModel>> doLogin(
      String username, String password) async {
    return executeEither(() async {
      final result = await remoteDataSource.doLogin(username, password);

      await sharedPref.saveUserAndToken(LoginResponse(
          accessToken: result.accessToken,
          tokenType: result.tokenType,
          data: result.data));
      return result.toEntity();
    });
  }

  @override
  Future<Either<Failure, bool>> doLogout() async {
    return executeEither(() async {
      final result = await remoteDataSource.doLogout();

      if (result) {
        sharedPref.removeDataPref();
      }
      return result;
    });
  }

  @override
  Future<Either<Failure, bool>> sendForgotPass(String email) {
    return executeEither(() async {
      final result = await remoteDataSource.sendForgotPassword(email);
      return result;
    });
  }

  @override
  Future<Either<Failure, bool>> changePassword(
      String oldPass, String newPass, String confirmPass) {
    return executeEither(() async {
      final result =
          await remoteDataSource.changePassword(oldPass, newPass, confirmPass);
      return result;
    });
  }
}
