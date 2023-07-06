import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:komtim_partner/common/failure.dart';
import 'package:komtim_partner/data/datasources/remote/auth_remote_datasource.dart';
import 'package:komtim_partner/domain/entities/login_model.dart';
import 'package:komtim_partner/domain/repositories/auth_repository.dart';

import '../../common/exception.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, LoginModel>> doLogin(String username, String password,
      String loginFrom, String fcmToken) async {
    try {
      final result = await remoteDataSource.doLogin(
          username, password, loginFrom, fcmToken);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
