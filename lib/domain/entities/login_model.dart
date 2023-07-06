import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  String status;
  int code;
  LoginDataModel data;
  String? message;

  LoginModel(
      {required this.status,
      required this.code,
      required this.data,
      required this.message});

  @override
  List<Object?> get props => [status, code, data, message];
}

class LoginDataModel extends Equatable {
  String? accessToken;
  String? tokenType;
  int? userId;
  String? expiresAt;

  LoginDataModel(
      {required this.accessToken,
      required this.tokenType,
      required this.userId,
      required this.expiresAt});

  @override
  List<Object?> get props => [accessToken, tokenType, userId, expiresAt];
}
