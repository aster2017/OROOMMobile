// To parse this JSON data, do
//
//     final hotel = hotelFromJson(jsonString);

import 'dart:convert';

List<Hotel> hotelFromJson(List<dynamic> str) =>
    List<Hotel>.from((str).map((x) => Hotel.fromJson(x)));

String hotelToJson(List<Hotel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Hotel {
  Hotel({
    this.hotelId,
    this.uri,
    this.hotelName,
    this.imageUrl,
    this.location,
    this.description,
    this.startPrice,
    this.displayOrder,
  });

  final int? hotelId;
  final String? uri;
  final String? hotelName;
  final String? imageUrl;
  final String? location;
  final String? description;
  final double? startPrice;
  final int? displayOrder;

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
        hotelId: json["hotelId"],
        uri: json["uri"],
        hotelName: json["hotelName"],
        imageUrl: json["imageUrl"],
        location: json["location"],
        description: json["description"],
        startPrice: json["startPrice"],
        displayOrder: json["displayOrder"],
      );

  Map<String, dynamic> toJson() => {
        "hotelId": hotelId,
        "uri": uri,
        "hotelName": hotelName,
        "imageUrl": imageUrl,
        "location": location,
        "description": description,
        "startPrice": startPrice,
        "displayOrder": displayOrder,
      };
}
