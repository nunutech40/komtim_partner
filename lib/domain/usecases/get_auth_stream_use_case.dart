import 'dart:ffi';

import 'package:komtim_partner/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import '../../common/failure.dart';

class GetAuthStreamUseCase {
  final AuthRepository _repository;

  const GetAuthStreamUseCase(this._repository);

  Stream<Either<Failure, bool>> execute() {
    return _repository.authState;
  }
}
