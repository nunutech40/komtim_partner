import 'package:dartz/dartz.dart';
import 'package:komtim_partner/domain/entities/profile_model.dart';
import '../../common/failure.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileModel>> getProfile();
}
