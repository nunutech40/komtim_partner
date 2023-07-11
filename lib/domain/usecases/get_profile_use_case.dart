import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:komtim_partner/domain/entities/profile_model.dart';
import 'package:komtim_partner/domain/repositories/profile_repository.dart';
import '../../common/failure.dart';

class GetProfileUseCase {
  final ProfileRepository _repository;

  const GetProfileUseCase(this._repository);

  Future<Either<Failure, ProfileModel>> execute() {
    return _repository.getProfile();
  }
}
