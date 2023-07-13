import 'package:komtim_partner/domain/entities/login_model.dart';
import 'package:dartz/dartz.dart';
import '../../common/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginModel>> doLogin(String username, String password);
  Future<Either<Failure, bool>> getAuthState();
  Future<Either<Failure, bool>> doLogout();
  Future<Either<Failure, bool>> sendForgotPass(String email);
  Future<Either<Failure, bool>> changePassword(
      String oldPass, String newPass, String confirmPass);
}
