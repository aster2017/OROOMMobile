// To parse this JSON data, do
//
//     final userDetail = userDetailFromJson(jsonString);

import 'dart:convert';

UserDetail userDetailFromJson(String str) =>
    UserDetail.fromJson(json.decode(str));

String userDetailToJson(UserDetail data) => json.encode(data.toJson());

class UserDetail {
  UserDetail({
    this.id,
    this.userName,
    this.email,
    this.emailConfirmed,
    this.phoneNumber,
    this.phoneNumberConfirmed,
    this.firstName,
    this.lastName,
    this.locale,
    this.orgId,
  });

  final String? id;
  final String? userName;
  final String? email;
  final bool? emailConfirmed;
  final String? phoneNumber;
  final bool? phoneNumberConfirmed;
  final String? firstName;
  final String? lastName;
  final String? locale;
  final String? orgId;

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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "email": email,
        "emailConfirmed": emailConfirmed,
        "phoneNumber": phoneNumber,
        "phoneNumberConfirmed": phoneNumberConfirmed,
        "firstName": firstName,
        "lastName": lastName,
        "locale": locale,
        "orgId": orgId,
      };
}
