// To parse this JSON data, do
//
//     final hotelDetailModel = hotelDetailModelFromJson(jsonString);

HotelDetailModel hotelDetailModelFromJson(Map<String, dynamic> str) =>
    HotelDetailModel.fromJson(str);

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
  final List<LatestReview>? latestReview;
  final List<HotelImage>? hotelImage;

  factory HotelDetailModel.fromJson(Map<String, dynamic> json) =>
      HotelDetailModel(
        hotelName: json["hotelName"],
        hotelUri: json["hotelUri"],
        location: json["location"],
        description: json["description"],
        hotelFacilities: json["hotelFacilities"] == null
            ? []
            : List<HotelFacility>.from(
                json["hotelFacilities"]!.map((x) => HotelFacility.fromJson(x))),
        chooseYourRoom: json["chooseYourRoom"] == null
            ? []
            : List<ChooseYourRoom>.from(
                json["chooseYourRoom"]!.map((x) => ChooseYourRoom.fromJson(x))),
        privacy: json["privacy"],
        checkInCheckOut: json["checkInCheckOut"],
        longitude: double.tryParse(json["longitude"]?.toString() ?? "0"),
        latitude: double.tryParse(json["latitude"]?.toString() ?? "0"),
        hotelReview: json["hotelReview"],
        latestReview: json["latestReview"] == null
            ? []
            : List<LatestReview>.from(
                json["latestReview"]!.map((x) => LatestReview.fromJson(x))),
        hotelImage: json["hotelImage"] == null
            ? []
            : List<HotelImage>.from(
                json["hotelImage"]!.map((x) => HotelImage.fromJson(x))),
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
    this.availableRoomGuids,
    this.categoryFeeOrDiscount,
    this.roomCategoryAmenities,
    this.roomCategoryFacilities,
    this.roomCategoryImages,
    this.itemPricePer,
    this.noOfExtraBeds,
    this.maxAdults,
    this.maxChild,
  });

  final int? roomCategoryId;
  final String? roomCategory;
  final String? roomCategoryUri;
  final String? roomCategoryDescription;
  final double? minPrice;
  final double? minProductCost;
  final int? noOfRooms;
  final double? itemPricePer;
  final int? noOfExtraBeds;
  final int? maxAdults;
  final int? maxChild;
  final String? refundableNonRefundable;
  final String? availableRoomGuids;
  final List<CategoryFeeOrDiscount>? categoryFeeOrDiscount;
  final List<RoomCategoryAmenity>? roomCategoryAmenities;
  final List<RoomCategoryFacility>? roomCategoryFacilities;
  final List<RoomCategoryImage>? roomCategoryImages;

  factory ChooseYourRoom.fromJson(Map<String, dynamic> json) => ChooseYourRoom(
        roomCategoryId: json["roomCategoryID"],
        roomCategory: json["roomCategory"],
        roomCategoryUri: json["roomCategoryUri"],
        roomCategoryDescription: json["roomCategoryDescription"],
        minPrice: double.tryParse(json["minPrice"]?.toString() ?? "0"),
        minProductCost:
            double.tryParse(json["minProductCost"]?.toString() ?? "0"),
        noOfRooms: json["noOfRooms"],
        itemPricePer: double.tryParse(json['itemPricePer']?.toString() ?? "0"),
        noOfExtraBeds: json['noOfExtraBeds'],
        maxAdults: json['maxAdults'],
        maxChild: json['maxChild'],
        refundableNonRefundable: json["refundableNonRefundable"],
        availableRoomGuids: json["availableRoomGuids"],
        categoryFeeOrDiscount: json["categoryFeeOrDiscount"] == null
            ? []
            : List<CategoryFeeOrDiscount>.from(json["categoryFeeOrDiscount"]!
                .map((x) => CategoryFeeOrDiscount.fromJson(x))),
        roomCategoryAmenities: json["roomCategoryAmenities"] == null
            ? []
            : List<RoomCategoryAmenity>.from(json["roomCategoryAmenities"]!
                .map((x) => RoomCategoryAmenity.fromJson(x))),
        roomCategoryFacilities: json["roomCategoryFacilities"] == null
            ? []
            : List<RoomCategoryFacility>.from(json["roomCategoryFacilities"]!
                .map((x) => RoomCategoryFacility.fromJson(x))),
        roomCategoryImages: json["roomCategoryImages"] == null
            ? []
            : List<RoomCategoryImage>.from(json["roomCategoryImages"]!
                .map((x) => RoomCategoryImage.fromJson(x))),
      );
}

class CategoryFeeOrDiscount {
  CategoryFeeOrDiscount({
    this.categoryFeeOrDiscountId,
    this.feeOrDiscountName,
    this.feeOrDiscountId,
    this.percentageOrAmount,
    this.isPercentage,
    this.formula,
    this.displayOrder,
    this.companyId,
    this.branchId,
    this.catgoryId,
    this.direction,
  });

  final int? categoryFeeOrDiscountId;
  final String? feeOrDiscountName;
  final int? feeOrDiscountId;
  final double? percentageOrAmount;
  final bool? isPercentage;
  final String? formula;
  final int? displayOrder;
  final int? companyId;
  final int? branchId;
  final int? catgoryId;
  final int? direction;

  factory CategoryFeeOrDiscount.fromJson(Map<String, dynamic> json) =>
      CategoryFeeOrDiscount(
        categoryFeeOrDiscountId: json["categoryFeeOrDiscountId"],
        feeOrDiscountName: json["feeOrDiscountName"],
        feeOrDiscountId: json["feeOrDiscountId"],
        percentageOrAmount:
            double.tryParse(json["percentageOrAmount"]?.toString() ?? "0"),
        isPercentage: json["isPercentage"],
        formula: json["formula"],
        displayOrder: json["displayOrder"],
        companyId: json["companyId"],
        branchId: json["branchId"],
        catgoryId: json["catgoryId"],
        direction: json["direction"],
      );

  Map<String, dynamic> toJson() => {
        "categoryFeeOrDiscountId": categoryFeeOrDiscountId,
        "feeOrDiscountName": feeOrDiscountName,
        "feeOrDiscountId": feeOrDiscountId,
        "percentageOrAmount": percentageOrAmount,
        "isPercentage": isPercentage,
        "formula": formula,
        "displayOrder": displayOrder,
        "companyId": companyId,
        "branchId": branchId,
        "catgoryId": catgoryId,
        "direction": direction,
      };
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

class RoomCategoryFacility {
  RoomCategoryFacility({
    this.roomCategoryId,
    this.facilityName,
    this.facilityIcon,
  });

  final int? roomCategoryId;
  final String? facilityName;
  final String? facilityIcon;

  factory RoomCategoryFacility.fromJson(Map<String, dynamic> json) =>
      RoomCategoryFacility(
        roomCategoryId: json["roomCategoryID"],
        facilityName: json["facilityName"],
        facilityIcon: json["facilityIcon"],
      );

  Map<String, dynamic> toJson() => {
        "roomCategoryID": roomCategoryId,
        "facilityName": facilityName,
        "facilityIcon": facilityIcon,
      };
}

class RoomCategoryImage {
  RoomCategoryImage({
    this.roomCategoryId,
    this.id,
    this.imageUrl,
  });

  final int? roomCategoryId;
  final int? id;
  final String? imageUrl;

  factory RoomCategoryImage.fromJson(Map<String, dynamic> json) =>
      RoomCategoryImage(
        roomCategoryId: json["roomCategoryID"],
        id: json["id"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "roomCategoryID": roomCategoryId,
        "id": id,
        "imageUrl": imageUrl,
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

class HotelImage {
  HotelImage({
    this.id,
    this.imageUrl,
  });

  final int? id;
  final String? imageUrl;

  factory HotelImage.fromJson(Map<String, dynamic> json) => HotelImage(
        id: json["id"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "imageUrl": imageUrl,
      };
}

class LatestReview {
  LatestReview({
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
  final double? rating;
  final DateTime? createdDate;
  final String? review;
  final String? email;

  factory LatestReview.fromJson(Map<String, dynamic> json) => LatestReview(
        firstName: json["firstName"],
        lastName: json["lastName"],
        hotelUri: json["hotelUri"],
        rating: double.tryParse(json["rating"]?.toString() ?? ""),
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        review: json["review"],
        email: json["email"],
      );
}
