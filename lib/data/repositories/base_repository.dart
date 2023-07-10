import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:komtim_partner/common/failure.dart';

import '../../common/exception.dart';

mixin RepositoryMixin {
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

  Future<Either<Failure, T>> executeEitherPref<T>(
      Future<T> Function() f) async {
    try {
      final result = await f();
      return Right(result);
    } catch (e) {
      return Left(UnknownFailure('Unexpected Error: ${e.toString()}'));
    }
  }
}
