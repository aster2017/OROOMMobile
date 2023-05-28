// To parse this JSON data, do
//
//     final myBookingModel = myBookingModelFromJson(jsonString);

List<MyBookingModel> myBookingModelFromJson(List<dynamic> str) =>
    List<MyBookingModel>.from((str).map((x) => MyBookingModel.fromJson(x)));

class MyBookingModel {
  final int? roomBookingId;
  final String? roomBookingGuid;
  final String? bookingNumber;
  final String? customerGuid;
  final String? hotelName;
  final String? categoryIcon;
  final String? categoryName;
  final DateTime? bookingDateFrom;
  final DateTime? bookingDateTo;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final int? noOfRooms;
  final int? noOfAdults;
  final String? childAges;
  final int? bookingStatusId;
  final String? bookingStatus;
  final String? paymentProvider;
  final int? paymentStatusCodeId;
  final String? paymentStatus;
  final String? cancelStatus;
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
  final String? comments;
  final bool? isBookingCancelled;
  final String? cancellationReason;

  MyBookingModel({
    required this.roomBookingId,
    required this.roomBookingGuid,
    required this.bookingNumber,
    required this.customerGuid,
    required this.hotelName,
    required this.categoryIcon,
    required this.categoryName,
    required this.bookingDateFrom,
    required this.bookingDateTo,
    required this.checkInDate,
    required this.checkOutDate,
    required this.noOfRooms,
    required this.noOfAdults,
    required this.childAges,
    required this.bookingStatusId,
    required this.bookingStatus,
    required this.paymentProvider,
    required this.paymentStatusCodeId,
    required this.paymentStatus,
    required this.cancelStatus,
    required this.price,
    required this.subTotal,
    required this.totalCharge,
    required this.totalDiscount,
    required this.grandTotal,
    required this.firstname,
    required this.lastname,
    required this.emailId,
    required this.mobileNo,
    required this.mobileCode,
    required this.comments,
    required this.isBookingCancelled,
    required this.cancellationReason,
  });

  factory MyBookingModel.fromJson(Map<String, dynamic> json) => MyBookingModel(
        roomBookingId: json["roomBookingId"],
        roomBookingGuid: json["roomBookingGuid"],
        bookingNumber: json["bookingNumber"],
        customerGuid: json["customerGuid"],
        hotelName: json["hotelName"],
        categoryIcon: json["categoryIcon"],
        categoryName: json["categoryName"],
        bookingDateFrom: json['bookingDateFrom'] == null
            ? null
            : DateTime.parse(json["bookingDateFrom"]),
        bookingDateTo: json['bookingDateTo'] == null
            ? null
            : DateTime.parse(json["bookingDateTo"]),
        checkInDate: json['checkInDate'] == null
            ? null
            : DateTime.parse(json["checkInDate"]),
        checkOutDate: json['checkOutDate'] == null
            ? null
            : DateTime.parse(json["checkOutDate"]),
        noOfRooms: json["noOfRooms"],
        noOfAdults: json["noOfAdults"],
        childAges: json["childAges"],
        bookingStatusId: json["bookingStatusId"],
        bookingStatus: json["bookingStatus"],
        paymentProvider: json["paymentProvider"],
        paymentStatusCodeId: json["paymentStatusCodeId"],
        paymentStatus: json["paymentStatus"],
        cancelStatus: json["cancelStatus"],
        price: json["price"]?.toDouble(),
        subTotal: json["subTotal"]?.toDouble(),
        totalCharge: json["totalCharge"]?.toDouble(),
        totalDiscount: json["totalDiscount"],
        grandTotal: json["grandTotal"]?.toDouble(),
        firstname: json["firstname"],
        lastname: json["lastname"],
        emailId: json["emailId"],
        mobileNo: json["mobileNo"],
        mobileCode: json["mobileCode"],
        comments: json["comments"],
        isBookingCancelled: json["isBookingCancelled"],
        cancellationReason: json["cancellationReason"],
      );
}
