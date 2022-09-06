// To parse this JSON data, do
//
//     final HotelDetailModel = HotelDetailModelFromJson(jsonString);

import 'dart:convert';

HotelDetailModel hotelDetailModelFromJson(Map<String, dynamic> str) =>
    HotelDetailModel.fromJson((str));

class HotelDetailModel {
  HotelDetailModel({
    this.hotelName,
    this.hotelUri,
    this.location,
    this.description,
    this.hotelFacilities,
    this.chooseYourRoom,
    this.privacy,
    this.checkInCheckOut,
    this.longitude,
    this.latitude,
    this.hotelReview,
    this.latestReview,
    this.hotelImage,
  });

  final String? hotelName;
  final String? hotelUri;
  final String? location;
  final String? description;
  final List<HotelFacility>? hotelFacilities;
  final List<ChooseYourRoom>? chooseYourRoom;
  final String? privacy;
  final String? checkInCheckOut;
  final double? longitude;
  final double? latitude;
  final String? hotelReview;
  final List<Review>? latestReview;
  final List<dynamic>? hotelImage;

  factory HotelDetailModel.fromJson(Map<String, dynamic> json) =>
      HotelDetailModel(
        hotelName: json["hotelName"],
        hotelUri: json["hotelUri"],
        location: json["location"],
        description: json["description"],
        hotelFacilities: List<HotelFacility>.from(
            json["hotelFacilities"].map((x) => HotelFacility.fromJson(x))),
        chooseYourRoom: List<ChooseYourRoom>.from(
            json["chooseYourRoom"].map((x) => ChooseYourRoom.fromJson(x))),
        privacy: json["privacy"],
        checkInCheckOut: json["checkInCheckOut"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        hotelReview: json["hotelReview"],
        latestReview: List<Review>.from(
            json["latestReview"].map((x) => Review.fromJson(x))),
        hotelImage: List<String>.from(json["hotelImage"].map((x) => x)),
      );
}

class ChooseYourRoom {
  ChooseYourRoom({
    this.roomCategoryId,
    this.roomCategory,
    this.roomCategoryUri,
    this.roomCategoryDescription,
    this.minPrice,
    this.minProductCost,
    this.noOfRooms,
    this.refundableNonRefundable,
    this.roomCategoryAmenities,
    this.roomCategoryFacilities,
    this.roomCategoryImages,
  });

  final int? roomCategoryId;
  final String? roomCategory;
  final String? roomCategoryUri;
  final String? roomCategoryDescription;
  final int? minPrice;
  final int? minProductCost;
  final int? noOfRooms;
  final String? refundableNonRefundable;
  final List<RoomCategoryAmenity>? roomCategoryAmenities;
  final List<Map<String, dynamic>>? roomCategoryFacilities;
  final List<String>? roomCategoryImages;

  factory ChooseYourRoom.fromJson(Map<String, dynamic> json) => ChooseYourRoom(
        roomCategoryId: json["roomCategoryID"],
        roomCategory: json["roomCategory"],
        roomCategoryUri: json["roomCategoryUri"],
        roomCategoryDescription: json["roomCategoryDescription"],
        minPrice: json["minPrice"],
        minProductCost: json["minProductCost"],
        noOfRooms: json["noOfRooms"],
        refundableNonRefundable: json["refundableNonRefundable"],
        roomCategoryAmenities: List<RoomCategoryAmenity>.from(
            json["roomCategoryAmenities"]
                .map((x) => RoomCategoryAmenity.fromJson(x))),
        roomCategoryFacilities: List<Map<String, dynamic>>.from(
            json["roomCategoryFacilities"].map((x) => x)),
        roomCategoryImages:
            List<String>.from(json["roomCategoryImages"].map((x) => x)),
      );
}

class RoomCategoryAmenity {
  RoomCategoryAmenity({
    this.roomCategoryId,
    this.amenitiesName,
    this.amenitiesIcon,
  });

  final int? roomCategoryId;
  final String? amenitiesName;
  final String? amenitiesIcon;

  factory RoomCategoryAmenity.fromJson(Map<String, dynamic> json) =>
      RoomCategoryAmenity(
        roomCategoryId: json["roomCategoryID"],
        amenitiesName: json["amenitiesName"],
        amenitiesIcon: json["amenitiesIcon"],
      );

  Map<String, dynamic> toJson() => {
        "roomCategoryID": roomCategoryId,
        "amenitiesName": amenitiesName,
        "amenitiesIcon": amenitiesIcon,
      };
}

class HotelFacility {
  HotelFacility({
    this.facilityName,
    this.facilityIcon,
  });

  final String? facilityName;
  final String? facilityIcon;

  factory HotelFacility.fromJson(Map<String, dynamic> json) => HotelFacility(
        facilityName: json["facilityName"],
        facilityIcon: json["facilityIcon"],
      );

  Map<String, dynamic> toJson() => {
        "facilityName": facilityName,
        "facilityIcon": facilityIcon,
      };
}

class Review {
  Review({
    this.firstName,
    this.lastName,
    this.hotelUri,
    this.rating,
    this.createdDate,
    this.review,
    this.email,
  });

  final String? firstName;
  final String? lastName;
  final String? hotelUri;
  final int? rating;
  final DateTime? createdDate;
  final String? review;
  final String? email;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        firstName: json["firstName"],
        lastName: json["lastName"],
        hotelUri: json["hotelUri"],
        rating: json["rating"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        review: json["review"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "hotelUri": hotelUri,
        "rating": rating,
        "createdDate": createdDate!.toIso8601String(),
        "review": review,
        "email": email,
      };
}
