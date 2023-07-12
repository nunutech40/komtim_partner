import 'package:komtim_partner/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import '../../common/failure.dart';

class SendForgotPasswordUseCase {
  final AuthRepository repository;

  SendForgotPasswordUseCase(this.repository);

  Future<Either<Failure, bool>> execute(String email) {
    return repository.sendForgotPass(email);
  }
}
