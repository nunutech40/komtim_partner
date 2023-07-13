import 'package:komtim_partner/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import '../../common/failure.dart';

class ChangePasswordUseCase {
  final AuthRepository repository;

  ChangePasswordUseCase(this.repository);

  Future<Either<Failure, bool>> execute(
      String oldPass, String newPass, String confirmPass) {
    return repository.changePassword(oldPass, newPass, confirmPass);
  }
}
