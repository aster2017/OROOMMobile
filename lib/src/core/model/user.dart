// To parse this JSON data, do
//
//     final userDetail = userDetailFromJson(jsonString);

import 'dart:convert';

UserDetail userDetailFromJson(String str) =>
    UserDetail.fromJson(json.decode(str));

class UserDetail {
  UserDetail(
      {this.id,
      this.userName,
      this.email,
      this.emailConfirmed,
      this.phoneNumber,
      this.phoneNumberConfirmed,
      this.firstName,
      this.lastName,
      this.locale,
      this.orgId,
      this.countryID,
      this.stateID,
      this.cityID,
      this.address1,
      this.loyaltyPoint,
      this.loyaltyPointAmount});

  final String? id;
  final String? userName;
  final String? email;
  final bool? emailConfirmed;
  final String? phoneNumber;
  final bool? phoneNumberConfirmed;
  final String? firstName;
  final String? lastName;
  final String? locale;
  final String? countryID;
  final String? stateID;
  final String? cityID;
  final String? address1;
  final String? orgId;
  final double? loyaltyPointAmount;
  final double? loyaltyPoint;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        id: json["id"],
        userName: json["userName"],
        email: json["email"],
        emailConfirmed: json["emailConfirmed"],
        phoneNumber: json["phoneNumber"],
        phoneNumberConfirmed: json["phoneNumberConfirmed"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        locale: json["locale"],
        orgId: json["orgId"],
        countryID: json['countryID'],
        stateID: json['stateID'],
        cityID: json['cityID'],
        address1: json['address1'],
        loyaltyPointAmount:
            double.tryParse(json["loyaltyPointAmount"]?.toString() ?? "0"),
        loyaltyPoint: double.tryParse(json["loyaltyPoint"]?.toString() ?? "0"),
      );
}
