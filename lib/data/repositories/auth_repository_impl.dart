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
  Future<Either<Failure, LoginModel>> doLogin(
      String username, String password) async {
    try {
      final result = await remoteDataSource.doLogin(username, password);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException catch (e) {
      return Left(ConnectionFailure('Failed to connect to the network: ${e.message}'));
    } catch (e) {
      return Left(UnknownFailure('Unexpected Error: ${e.toString()}'));
    }
  }
}

