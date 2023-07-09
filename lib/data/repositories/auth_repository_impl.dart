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

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SharedPref sharedPref;
  late final StreamController<Either<Failure, bool>> _authStateController;

  AuthRepositoryImpl(
      {required this.remoteDataSource, required this.sharedPref}) {
    _authStateController = StreamController<Either<Failure, bool>>();
    // Listen to the isLoggedInStream from sharedPref
    // and push to the _authStateController
    sharedPref.isLoggedInStream.listen((isLoggedIn) {
      _authStateController.add(Right(isLoggedIn));
    });
  }

  @override
  Stream<Either<Failure, bool>> get authState => _authStateController.stream;

  @override
  Future<Either<Failure, bool>> getAuthState() async {
    try {
      bool isLoggedIn = await sharedPref.isLoggedIn();
      _authStateController.add(Right(isLoggedIn));
      return Right(isLoggedIn);
    } catch (e) {
      _authStateController
          .add(Left(UnknownFailure('Unexpected Error: ${e.toString()}')));
      return Left(UnknownFailure('Unexpected Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, LoginModel>> doLogin(
      String username, String password) async {
    try {
      // login and get data login, token and user
      final result = await remoteDataSource.doLogin(username, password);
      
      // save to preferences
      sharedPref.saveUserAndToken(LoginResponse(
          accessToken: result.accessToken,
          tokenType: result.tokenType,
          data: result.data));

      return Right(result.toEntity());
    } on ServerException catch (e) {
      _authStateController.add(Left(ServerFailure(e.message)));
      return Left(ServerFailure(e.message));
    } on SocketException catch (e) {
      _authStateController.add(Left(
          ConnectionFailure('Failed to connect to the network: ${e.message}')));
      return Left(
          ConnectionFailure('Failed to connect to the network: ${e.message}'));
    } catch (e) {
      _authStateController
          .add(Left(UnknownFailure('Unexpected Error: ${e.toString()}')));
      return Left(UnknownFailure('Unexpected Error: ${e.toString()}'));
    }
  }

  void dispose() {
    _authStateController.close();
  }
}
