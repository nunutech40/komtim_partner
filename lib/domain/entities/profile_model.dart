import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  int? id;
  int partnerId;
  String? partnerNo;
  String? fullname;
  String? username;
  String? email;
  String? noTelp;
  String? address;
  String? joinDate;
  String? bankName;
  String? bankAccountNumber;
  String? photoProfileUrl;
  String? createdAt;
  String? updatedAt;

  ProfileModel({
    this.id,
    required this.partnerId,
    this.partnerNo,
    this.fullname,
    this.username,
    this.email,
    this.noTelp,
    this.address,
    this.joinDate,
    this.bankName,
    this.bankAccountNumber,
    this.photoProfileUrl,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        partnerId,
        partnerNo,
        fullname,
        username,
        email,
        noTelp,
        address,
        joinDate,
        bankName,
        bankAccountNumber,
        photoProfileUrl,
        createdAt,
        updatedAt,
      ];
}
