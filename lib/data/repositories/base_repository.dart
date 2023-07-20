import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:komtim_partner/common/failure.dart';

import '../../common/exception.dart';

abstract class BaseRepository {
  Future<Either<Failure, T>> executeEither<T>(Future<T> Function() f) async {
    try {
      final result = await f();
      print('cek result here: $result');
      return Right(result);
    } on ServerException catch (e) {
      print('cek result ServerException: $e');
      return Left(ServerFailure(e.message));
    } on SocketException catch (e) {
      print('cek result SocketException: $e');
      return Left(
          ConnectionFailure('Failed to connect to the network: ${e.message}'));
    } catch (e) {
      print('cek result UnknownFailure: $e');
      return Left(UnknownFailure('Unexpected Error: ${e.toString()}'));
    }
  }

  Future<Either<Failure, T>> executeEitherPref<T>(
      Future<T> Function() f) async {
    return executeEither(f);
  }
}
