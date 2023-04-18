// To parse this JSON data, do
//
//     final myBookingModel = myBookingModelFromJson(jsonString);

import 'dart:convert';

List<MyBookingModel> myBookingModelFromJson(List<dynamic> str) =>
    List<MyBookingModel>.from((str).map((x) => MyBookingModel.fromJson(x)));

String myBookingModelToJson(List<MyBookingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyBookingModel {
  MyBookingModel({
    this.roomBookingFeeOrDiscountDto,
    this.roomBookingId,
    this.roomBookingGuid,
    this.bookingNumber,
    this.customerGuid,
    this.hotelName,
    this.categoryIcon,
    this.categoryName,
    this.bookingDateFrom,
    this.bookingDateTo,
    this.noOfRooms,
    this.noOfAdults,
    this.childAges,
    this.bookingStatusId,
    this.bookingStatus,
    this.paymentStatusCodeId,
    this.paymentStatus,
    this.price,
    this.subTotal,
    this.totalCharge,
    this.totalDiscount,
    this.grandTotal,
    this.firstname,
    this.lastname,
    this.emailId,
    this.mobileNo,
    this.mobileCode,
    this.comments,
  });

  final List<RoomBookingFeeOrDiscountDto>? roomBookingFeeOrDiscountDto;
  final int? roomBookingId;
  final String? roomBookingGuid;
  final String? bookingNumber;
  final String? customerGuid;
  final String? hotelName;
  final dynamic categoryIcon;
  final String? categoryName;
  final DateTime? bookingDateFrom;
  final DateTime? bookingDateTo;
  final int? noOfRooms;
  final int? noOfAdults;
  final String? childAges;
  final int? bookingStatusId;
  final String? bookingStatus;
  final int? paymentStatusCodeId;
  final String? paymentStatus;
  final double? price;
  final double? subTotal;
  final double? totalCharge;
  final double? totalDiscount;
  final double? grandTotal;
  final String? firstname;
  final String? lastname;
  final String? emailId;
  final String? mobileNo;
  final String? mobileCode;
  final dynamic comments;

  factory MyBookingModel.fromJson(Map<String, dynamic> json) => MyBookingModel(
        roomBookingFeeOrDiscountDto: json["roomBookingFeeOrDiscountDto"] == null
            ? []
            : List<RoomBookingFeeOrDiscountDto>.from(
                json["roomBookingFeeOrDiscountDto"]!
                    .map((x) => RoomBookingFeeOrDiscountDto.fromJson(x))),
        roomBookingId: json["roomBookingId"],
        roomBookingGuid: json["roomBookingGuid"],
        bookingNumber: json["bookingNumber"],
        customerGuid: json["customerGuid"],
        hotelName: json["hotelName"],
        categoryIcon: json["categoryIcon"],
        categoryName: json["categoryName"],
        bookingDateFrom: json["bookingDateFrom"] == null
            ? null
            : DateTime.parse(json["bookingDateFrom"]),
        bookingDateTo: json["bookingDateTo"] == null
            ? null
            : DateTime.parse(json["bookingDateTo"]),
        noOfRooms: json["noOfRooms"],
        noOfAdults: json["noOfAdults"],
        childAges: json["childAges"],
        bookingStatusId: json["bookingStatusId"],
        bookingStatus: json["bookingStatus"],
        paymentStatusCodeId: json["paymentStatusCodeId"],
        paymentStatus: json["paymentStatus"],
        price: json["price"]?.toDouble(),
        subTotal: json["subTotal"]?.toDouble(),
        totalCharge: json["totalCharge"]?.toDouble(),
        totalDiscount: json["totalDiscount"]?.toDouble(),
        grandTotal: json["grandTotal"]?.toDouble(),
        firstname: json["firstname"],
        lastname: json["lastname"],
        emailId: json["emailId"],
        mobileNo: json["mobileNo"],
        mobileCode: json["mobileCode"],
        comments: json["comments"],
      );

  Map<String, dynamic> toJson() => {
        "roomBookingFeeOrDiscountDto": roomBookingFeeOrDiscountDto == null
            ? []
            : List<dynamic>.from(
                roomBookingFeeOrDiscountDto!.map((x) => x.toJson())),
        "roomBookingId": roomBookingId,
        "roomBookingGuid": roomBookingGuid,
        "bookingNumber": bookingNumber,
        "customerGuid": customerGuid,
        "hotelName": hotelName,
        "categoryIcon": categoryIcon,
        "categoryName": categoryName,
        "bookingDateFrom": bookingDateFrom?.toIso8601String(),
        "bookingDateTo": bookingDateTo?.toIso8601String(),
        "noOfRooms": noOfRooms,
        "noOfAdults": noOfAdults,
        "childAges": childAges,
        "bookingStatusId": bookingStatusId,
        "bookingStatus": bookingStatus,
        "paymentStatusCodeId": paymentStatusCodeId,
        "paymentStatus": paymentStatus,
        "price": price,
        "subTotal": subTotal,
        "totalCharge": totalCharge,
        "totalDiscount": totalDiscount,
        "grandTotal": grandTotal,
        "firstname": firstname,
        "lastname": lastname,
        "emailId": emailId,
        "mobileNo": mobileNo,
        "mobileCode": mobileCode,
        "comments": comments,
      };
}

class RoomBookingFeeOrDiscountDto {
  RoomBookingFeeOrDiscountDto({
    this.bookingFeeOrDiscountId,
    this.roomBookingId,
    this.feeOrDiscountId,
    this.feeOrDiscountName,
    this.percentageOrAmount,
    this.isPercentage,
    this.formula,
    this.displayOrder,
    this.direction,
    this.branchId,
  });

  final int? bookingFeeOrDiscountId;
  final int? roomBookingId;
  final int? feeOrDiscountId;
  final String? feeOrDiscountName;
  final double? percentageOrAmount;
  final bool? isPercentage;
  final dynamic formula;
  final int? displayOrder;
  final int? direction;
  final int? branchId;

  factory RoomBookingFeeOrDiscountDto.fromJson(Map<String, dynamic> json) =>
      RoomBookingFeeOrDiscountDto(
        bookingFeeOrDiscountId: json["bookingFeeOrDiscountID"],
        roomBookingId: json["roomBookingID"],
        feeOrDiscountId: json["feeOrDiscountId"],
        feeOrDiscountName: json["feeOrDiscountName"],
        percentageOrAmount: json["percentageOrAmount"]?.toDouble(),
        isPercentage: json["isPercentage"],
        formula: json["formula"],
        displayOrder: json["displayOrder"],
        direction: json["direction"],
        branchId: json["branchID"],
      );

  Map<String, dynamic> toJson() => {
        "bookingFeeOrDiscountID": bookingFeeOrDiscountId,
        "roomBookingID": roomBookingId,
        "feeOrDiscountId": feeOrDiscountId,
        "feeOrDiscountName": feeOrDiscountName,
        "percentageOrAmount": percentageOrAmount,
        "isPercentage": isPercentage,
        "formula": formula,
        "displayOrder": displayOrder,
        "direction": direction,
        "branchID": branchId,
      };
}
