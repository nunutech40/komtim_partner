import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  String? accessToken;
  String? tokenType;
  int? userId;
  String? expiresAt;

  LoginModel(
      {required this.accessToken,
      required this.tokenType,
      required this.userId,
      required this.expiresAt});

  @override
  List<Object?> get props => [accessToken, tokenType, userId, expiresAt];
}
