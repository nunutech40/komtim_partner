import 'package:equatable/equatable.dart';
import 'package:komtim_partner/domain/entities/login_model.dart';

class LoginResponse extends Equatable {
  final String? accessToken;
  final String? tokenType;
  final UserLoginData? data;

  const LoginResponse(
      {required this.accessToken, required this.tokenType, required this.data});

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "data": data,
      };

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      data: UserLoginData.fromJson(json['data']),
    );
  }

  // Convert to your entity class
  LoginModel toEntity() {
    return LoginModel(
        accessToken: accessToken, tokenType: tokenType, data: data?.toEntity());
  }

  @override
  List<Object?> get props => [
        accessToken,
        tokenType,
        data,
      ];
}

class UserLoginData extends Equatable {
  final int? id;
  final int? partnerId;
  final String? partnerNo;
  final String? username;
  final String? fullname;
  final String? email;

  UserLoginData({
    required this.id,
    required this.partnerId,
    required this.partnerNo,
    required this.username,
    required this.fullname,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "partner_id": partnerId,
        "partner_no": partnerNo,
        "username": username,
        "fullname": fullname,
        "email": email
      };

  factory UserLoginData.fromJson(Map<String, dynamic> json) {
    return UserLoginData(
      id: json['id'],
      partnerId: json['partner_id'],
      partnerNo: json['partner_no'],
      username: json['username'],
      fullname: json['fullname'],
      email: json['email'],
    );
  }

  UserLoginModel toEntity() {
    return UserLoginModel(
        id: id,
        partnerId: partnerId,
        partnerNo: partnerNo,
        username: username,
        fullname: fullname,
        email: email);
  }

  @override
  List<Object?> get props =>
      [id, partnerId, partnerNo, username, fullname, email];
}
