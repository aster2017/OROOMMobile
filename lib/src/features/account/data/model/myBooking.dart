// To parse this JSON data, do
//
//     final myBookingModel = myBookingModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<MyBookingModel> myBookingModelFromJson(List<dynamic> str) =>
    List<MyBookingModel>.from((str).map((x) => MyBookingModel.fromJson(x)));

String myBookingModelToJson(List<MyBookingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyBookingModel {
  MyBookingModel({
    this.roomBookingId,
    this.roomBookingGuid,
    this.customerGuid,
    this.hotelName,
    this.bookingDateFrom,
    this.bookingDateTo,
    this.noOfRooms,
    this.noOfAdults,
    this.childAges,
    this.bookingStatusId,
    this.price,
    this.subTotal,
    this.orderTax,
    this.serviceCharge,
    this.grandTotal,
    this.firstname,
    this.lastname,
    this.emailId,
    this.mobileNo,
    this.mobileCode,
    this.comments,
  });

  final int? roomBookingId;
  final String? roomBookingGuid;
  final String? customerGuid;
  final String? hotelName;
  final DateTime? bookingDateFrom;
  final DateTime? bookingDateTo;
  final int? noOfRooms;
  final int? noOfAdults;
  final String? childAges;
  final int? bookingStatusId;
  final double? price;
  final double? subTotal;
  final double? orderTax;
  final double? serviceCharge;
  final double? grandTotal;
  final String? firstname;
  final String? lastname;
  final String? emailId;
  final String? mobileNo;
  final String? mobileCode;
  final dynamic comments;

  factory MyBookingModel.fromJson(Map<String, dynamic> json) => MyBookingModel(
        roomBookingId: json["roomBookingId"],
        roomBookingGuid: json["roomBookingGuid"],
        customerGuid: json["customerGuid"],
        hotelName: json["hotelName"],
        bookingDateFrom: DateTime.parse(json["bookingDateFrom"]),
        bookingDateTo: DateTime.parse(json["bookingDateTo"]),
        noOfRooms: json["noOfRooms"],
        noOfAdults: json["noOfAdults"],
        childAges: json["childAges"],
        bookingStatusId: json["bookingStatusId"],
        price: double.parse(json["price"]?.toString() ?? "0"),
        subTotal: double.parse(json["subTotal"]?.toString() ?? "0"),
        orderTax: double.parse(json["orderTax"]?.toString() ?? "0"),
        serviceCharge: double.parse(json["serviceCharge"]?.toString() ?? "0"),
        grandTotal: double.parse(json["grandTotal"]?.toString() ?? "0"),
        firstname: json["firstname"],
        lastname: json["lastname"],
        emailId: json["emailId"],
        mobileNo: json["mobileNo"],
        mobileCode: json["mobileCode"],
        comments: json["comments"],
      );

  Map<String, dynamic> toJson() => {
        "roomBookingId": roomBookingId,
        "roomBookingGuid": roomBookingGuid,
        "customerGuid": customerGuid,
        "hotelName": hotelName,
        "bookingDateFrom": bookingDateFrom!.toIso8601String(),
        "bookingDateTo": bookingDateTo!.toIso8601String(),
        "noOfRooms": noOfRooms,
        "noOfAdults": noOfAdults,
        "childAges": childAges,
        "bookingStatusId": bookingStatusId,
        "price": price,
        "subTotal": subTotal,
        "orderTax": orderTax,
        "serviceCharge": serviceCharge,
        "grandTotal": grandTotal,
        "firstname": firstname,
        "lastname": lastname,
        "emailId": emailId,
        "mobileNo": mobileNo,
        "mobileCode": mobileCode,
        "comments": comments,
      };
}
