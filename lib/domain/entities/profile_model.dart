import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  final int? id;
  final int partnerId;
  final String? partnerNo;
  final String? fullname;
  final String? username;
  final String? email;
  final String? noTelp;
  final String? address;
  final String? joinDate;
  final String? bankName;
  final String? bankAccountNumber;
  final String? createdAt;
  final String? updatedAt;

  const ProfileModel({
    required this.id,
    required this.partnerId,
    required this.partnerNo,
    required this.fullname,
    required this.username,
    required this.email,
    required this.noTelp,
    required this.address,
    required this.joinDate,
    required this.bankName,
    required this.bankAccountNumber,
    required this.createdAt,
    required this.updatedAt,
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
        createdAt,
        updatedAt,
      ];
}
