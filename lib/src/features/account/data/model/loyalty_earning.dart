// To parse this JSON data, do
//
//     final portfolioEssentialsResponse = portfolioEssentialsResponseFromJson(jsonString);

List<LoyaltyEarnings> loyaltyEarningsFromJson(List<dynamic> str) =>
    List<LoyaltyEarnings>.from((str).map((x) => LoyaltyEarnings.fromJson(x)));

class LoyaltyEarnings {
  final int? loyaltyPointTransactionId;
  final int? branchId;
  final String? hotelName;
  final DateTime? earnedDate;
  final double? loyaltyPoint;
  final double? loyaltyPointAmount;
  final double? loyaltyPointId;
  final String? userId;
  final String? name;
  final String? requiredValueType;
  final double? points;
  final double? pointEquivalentAmount;
  final String? currency;

  LoyaltyEarnings({
    required this.loyaltyPointTransactionId,
    required this.branchId,
    required this.hotelName,
    required this.earnedDate,
    required this.loyaltyPoint,
    required this.loyaltyPointAmount,
    required this.loyaltyPointId,
    required this.userId,
    required this.name,
    required this.requiredValueType,
    required this.points,
    required this.pointEquivalentAmount,
    required this.currency,
  });

  factory LoyaltyEarnings.fromJson(Map<String, dynamic> json) =>
      LoyaltyEarnings(
        loyaltyPointTransactionId: json["loyaltyPointTransactionId"],
        branchId: json["branchId"],
        hotelName: json["hotelName"],
        earnedDate: json["earnedDate"] == null
            ? null
            : DateTime.parse(json["earnedDate"]),
        loyaltyPoint: json["loyaltyPoint"]?.toDouble(),
        loyaltyPointAmount: json["loyaltyPointAmount"]?.toDouble(),
        loyaltyPointId: json["loyaltyPointId"]?.toDouble(),
        userId: json["userId"],
        name: json["name"],
        requiredValueType: json["requiredValueType"],
        points: json["points"]?.toDouble(),
        pointEquivalentAmount: json["pointEquivalentAmount"]?.toDouble(),
        currency: json["currency"],
      );
}
