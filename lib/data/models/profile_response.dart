import 'package:equatable/equatable.dart';

class ProfileResponse extends Equatable {
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

  const ProfileResponse(
      {required this.id,
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
      required this.updatedAt});

  Map<String, dynamic> toJson() => {
        "id": id,
        "partner_id": partnerId,
        "partner_no": partnerNo,
        "fullname": fullname,
        "username": username,
        "email": email,
        "no_telp": noTelp,
        "address": address,
        "join_date": joinDate,
        "bank_name": bankName,
        "bank_account_number": bankAccountNumber,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      id: json['id'],
      partnerId: json['partner_id'],
      partnerNo: json['partner_no'],
      fullname: json['fullname'],
      username: json['username'],
      email: json['email'],
      noTelp: json['no_telp'],
      address: json['address'],
      joinDate: json['join_date'],
      bankName: json['bank_name'],
      bankAccountNumber: json['bank_account_number'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

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
