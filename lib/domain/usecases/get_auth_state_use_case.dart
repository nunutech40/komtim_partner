import 'dart:ffi';

import 'package:komtim_partner/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import '../../common/failure.dart';

class GetAuthStateUseCase {
  final AuthRepository _repository;

  const GetAuthStateUseCase(this._repository);

  Future<Either<Failure, bool>> execute() {
    return _repository.getAuthState();
  }
}
