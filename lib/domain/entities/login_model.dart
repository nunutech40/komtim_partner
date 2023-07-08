import 'dart:math';

import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  String? accessToken;
  String? tokenType;
  UserLoginModel? data;

  LoginModel({
    required this.accessToken,
    required this.tokenType,
    required this.data,
  });

  @override
  List<Object?> get props => [accessToken, tokenType, data];
}

class UserLoginModel extends Equatable {
  int? id;
  int? partnerId;
  String? partnerNo;
  String? username;
  String? fullname;
  String? email;

  UserLoginModel(
      {required this.id,
      required this.partnerId,
      required this.partnerNo,
      required this.username,
      required this.fullname,
      required this.email});

  @override
  List<Object?> get props =>
      [id, partnerId, partnerNo, username, fullname, email];
}
