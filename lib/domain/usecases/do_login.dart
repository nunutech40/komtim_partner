import 'package:komtim_partner/domain/entities/login_model.dart';
import 'package:komtim_partner/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import '../../common/failure.dart';

class DoLoginUseCase {
  final AuthRepository repository;

  DoLoginUseCase(this.repository);

  Future<Either<Failure, LoginModel>> execute(
      String username, String password, String loginFrom, String fcmToken) {
    return repository.doLogin(username, password, loginFrom, fcmToken);
  }
}
