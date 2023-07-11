import 'package:komtim_partner/domain/entities/login_model.dart';
import 'package:komtim_partner/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:komtim_partner/domain/usecases/get_profile_use_case.dart';
import '../../common/failure.dart';

class DoLoginUseCase {
  final AuthRepository repository;
  final GetProfileUseCase getProfileUseCase;
  DoLoginUseCase(this.repository, this.getProfileUseCase);

  Future<Either<Failure, LoginModel>> execute(
      String username, String password) async {
    final dataLogin = await repository.doLogin(username, password);
    await getProfileUseCase.execute();
    return dataLogin;
  }
}
