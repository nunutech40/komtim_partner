import 'package:komtim_partner/domain/entities/login_model.dart';
import 'package:komtim_partner/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import '../../common/failure.dart';

class DoLogoutUseCase {
  final AuthRepository repository;

  DoLogoutUseCase(this.repository);

  Future<Either<Failure, bool>> execute() {
    return repository.doLogout();
  }
}
