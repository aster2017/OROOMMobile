// To parse this JSON data, do
//
//     final hotelSearch = hotelSearchFromJson(jsonString);

import 'dart:convert';

List<HotelSearch> hotelSearchFromJson(List<dynamic> str) =>
    List<HotelSearch>.from((str).map((x) => HotelSearch.fromJson(x)));

String hotelSearchToJson(List<HotelSearch> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HotelSearch {
  HotelSearch({
    this.hotelId,
    this.hotelName,
    this.hotelUri,
    this.roomCategoryId,
    this.roomCategory,
    this.roomCategoryUri,
    this.roomCategoryDescription,
    this.roomCategoryImageUrl,
    this.roomCategoryHeaderImage,
    this.minPrice,
    this.minProductCost,
    this.noOfRooms,
    this.hotelReview,
    this.refundableNonRefundable,
  });

  final int? hotelId;
  final String? hotelName;
  final String? hotelUri;
  final int? roomCategoryId;
  final String? roomCategory;
  final String? roomCategoryUri;
  final String? roomCategoryDescription;
  final String? roomCategoryImageUrl;
  final String? roomCategoryHeaderImage;
  final double? minPrice;
  final double? minProductCost;
  final int? noOfRooms;
  final String? hotelReview;
  final String? refundableNonRefundable;

  factory HotelSearch.fromJson(Map<String, dynamic> json) => HotelSearch(
        hotelId: json["hotelID"],
        hotelName: json["hotelName"],
        hotelUri: json["hotelUri"],
        roomCategoryId: json["roomCategoryID"],
        roomCategory: json["roomCategory"],
        roomCategoryUri: json["roomCategoryUri"],
        roomCategoryDescription: json["roomCategoryDescription"],
        roomCategoryImageUrl: json["roomCategoryImageUrl"],
        roomCategoryHeaderImage: json["roomCategoryHeaderImage"],
        minPrice: double.tryParse(json["minPrice"]?.toString() ?? "0"),
        minProductCost:
            double.tryParse(json["minProductCost"]?.toString() ?? "0"),
        noOfRooms: json["noOfRooms"],
        hotelReview: json["hotelReview"],
        refundableNonRefundable: json["refundableNonRefundable"],
      );

  Map<String, dynamic> toJson() => {
        "hotelID": hotelId,
        "hotelName": hotelName,
        "hotelUri": hotelUri,
        "roomCategoryID": roomCategoryId,
        "roomCategory": roomCategory,
        "roomCategoryUri": roomCategoryUri,
        "roomCategoryDescription": roomCategoryDescription,
        "roomCategoryImageUrl": roomCategoryImageUrl,
        "roomCategoryHeaderImage": roomCategoryHeaderImage,
        "minPrice": minPrice,
        "minProductCost": minProductCost,
        "noOfRooms": noOfRooms,
        "hotelReview": hotelReview,
        "refundableNonRefundable": refundableNonRefundable,
      };
}
