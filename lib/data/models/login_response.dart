import 'package:equatable/equatable.dart';
import 'package:komtim_partner/domain/entities/login_model.dart';

class LoginResponse extends Equatable {
  final String status;
  final int code;
  final LoginData data;
  final String? message;

  const LoginResponse(
      {required this.status,
      required this.code,
      required this.data,
      required this.message});

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data": data,
        "message": message,
      };

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      code: json['code'],
      data: LoginData.fromJson(json['data']),
      message: json['message'],
    );
  }

  // Convert to your entity class
  LoginModel toEntity() {
    return LoginModel(
      status: status,
      code: code,
      data: data.toEntity(),
      message: message,
    );
  }

  @override
  List<Object?> get props => [
        status,
        code,
        data,
        message,
      ];
}

class LoginData extends Equatable {
  final String? accessToken;
  final String? tokenType;
  final int? userId;
  final String? expiresAt;

  const LoginData(
      {required this.accessToken,
      required this.tokenType,
      required this.userId,
      required this.expiresAt});

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "user_id": userId,
        "expires_at": expiresAt,
      };

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      userId: json['user_id'],
      expiresAt: json['expires_at'],
    );
  }

  // Convert to your entity class
  LoginDataModel toEntity() {
    return LoginDataModel(
      accessToken: accessToken,
      tokenType: tokenType,
      userId: userId,
      expiresAt: expiresAt,
    );
  }

  @override
  List<Object?> get props => [
        accessToken,
        tokenType,
        userId,
        expiresAt,
      ];
}
