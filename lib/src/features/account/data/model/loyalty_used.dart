// To parse this JSON data, do
//
//     final loyaltyUsed = loyaltyUsedFromJson(jsonString);

List<LoyaltyUsed> loyaltyUsedFromJson(List<dynamic> str) =>
    List<LoyaltyUsed>.from((str).map((x) => LoyaltyUsed.fromJson(x)));

class LoyaltyUsed {
  final int? loyaltyPointUsageId;
  final double? pointsUsed;
  final double? amountUsed;
  final String? onlineCustomerUserGuId;
  final String? usedReferenceId;
  final String? remarks;
  final DateTime? usageDate;
  final String? userId;
  final String? bookingNumber;
  final DateTime? bookingDateFrom;
  final int? branchId;
  final String? hotelName;

  LoyaltyUsed({
    required this.loyaltyPointUsageId,
    required this.pointsUsed,
    required this.amountUsed,
    required this.onlineCustomerUserGuId,
    required this.usedReferenceId,
    required this.remarks,
    required this.usageDate,
    required this.userId,
    required this.bookingNumber,
    required this.bookingDateFrom,
    required this.branchId,
    required this.hotelName,
  });

  factory LoyaltyUsed.fromJson(Map<String, dynamic> json) => LoyaltyUsed(
        loyaltyPointUsageId: json["loyaltyPointUsageId"],
        pointsUsed: json["pointsUsed"]?.toDouble(),
        amountUsed: json["amountUsed"]?.toDouble(),
        onlineCustomerUserGuId: json["onlineCustomerUserGuId"],
        usedReferenceId: json["usedReferenceId"],
        remarks: json["remarks"],
        usageDate: json['usageDate'] == null
            ? null
            : DateTime.parse(json["usageDate"]),
        userId: json["userId"],
        bookingNumber: json["bookingNumber"],
        bookingDateFrom: json['bookingDateFrom'] == null
            ? null
            : DateTime.parse(json["bookingDateFrom"]),
        branchId: json["branchId"],
        hotelName: json["hotelName"],
      );
}
