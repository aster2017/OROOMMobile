import 'dart:convert';

import 'package:orb/src/core/model/response_model.dart';
import 'package:orb/src/features/home/models/hotel_detail.dart';

import '../../features/home/models/hotel.dart';
import '../constants/api_endpoints.dart';
import '../services/dio_service.dart';

class HotelRepository {
  Future<List<Hotel>?> getFeatured() async {
    try {
      final tokenResponse =
          await DioService().client.get(APIEndpoints.featured);

      return hotelFromJson(tokenResponse.data);
    } on DioError catch (e) {
      if (e.response!.statusCode! >= 500) {
        throw "Internal Server Error!";
      } else {
        throw e.response!.statusMessage!;
      }
    } catch (e) {
      print(e.toString());
      throw "Something went wrong!";
    }
  }

  Future<List<Hotel>?> getPopular() async {
    try {
      final tokenResponse =
          await DioService().client.get(APIEndpoints.popularHotel);

      return hotelFromJson(tokenResponse.data);
    } on DioError catch (e) {
      if (e.response!.statusCode! >= 500) {
        throw "Internal Server Error!";
      } else {
        throw e.response!.statusMessage!;
      }
    } catch (e) {
      throw "Something went wrong!";
    }
  }

  Future<HotelDetailModel?> getHotelDetail(
      {required String uri,
      required String checkIn,
      required String checkOut}) async {
    try {
      final tokenResponse = await DioService().client.get(APIEndpoints.hotel,
          queryParameters: {
            "hotelUri": uri,
            "checkIn": checkIn,
            "checkOut": checkOut
          });
      print(tokenResponse.data);
      return hotelDetailModelFromJson(tokenResponse.data);
    } on DioError catch (e) {
      if (e.response!.statusCode! >= 500) {
        throw "Internal Server Error!";
      } else {
        throw e.response!.statusMessage!;
      }
    } catch (e) {
      print(e.toString());
      throw "Something went wrong!";
    }
  }

  Future<ResponseModel?> getSearchHotel(
      {required String string,
      required String location,
      required double minPrice,
      required double maxPrice,
      required String checkIn,
      required String checkOut}) async {
    try {
      final tokenResponse = await DioService()
          .client
          .get(APIEndpoints.searchHotel, queryParameters: {
        "QuerySearch": string,
        "location": location,
        "minPrice": minPrice,
        "maxPrice": maxPrice,
        "checkIn": checkIn,
        "checkOut": checkOut
      });

      return responseModelFromJson(tokenResponse.data);
    } on DioError catch (e) {
      print(e.response!.data);
      if (e.response!.statusCode! >= 500) {
        throw "Internal Server Error!";
      } else {
        throw e.response!.statusMessage!;
      }
    } catch (e) {
      print(e.toString());
      throw "Something went wrong!";
    }
  }

  Future<bool?> bookHotel({
    required String name,
    required String email,
    required String phone,
    required String checkIn,
    required String checkOut,
    required String hotelUri,
    required String childsAge,
    required ChooseYourRoom room,
    required int noOfRooms,
    required int noOfNights,
    required double subTotal,
    required int noOfAdults,
    required double extraCharg,
    required double orderTotal,
    required double price,
    required double orderTax,
    required Map<String, dynamic> paymentProvider,
  }) async {
    try {
      final data = {
        "branchUri": hotelUri,
        "categoryID": room.roomCategoryId,
        "itemID": room.roomCategoryId,
        "firstName": name.split(' ').first,
        "lastName": name.split(' ').length >= 2 ? name.split(' ').last : name,
        "phone": phone,
        "email": "user@example.com",
        "password": null,
        "price": price,
        "noOfRooms": noOfRooms,
        "noOfNights": noOfNights,
        "subTotal": subTotal,
        "noOfAdults": noOfAdults,
        "childAges": childsAge,
        "orderTax": orderTax,
        "extraCharge": extraCharg,
        "orderTotal": orderTotal,
        "checkInDate": checkIn,
        "checkOutDate": checkOut,
        "paymentTypeID": 1,
        "ipAddress": "string",
        "customerID": 0,
        "userId": "",
        "paymentProvider": paymentProvider
      };
      final tokenResponse =
          await DioService().client.post(APIEndpoints.booking, data: data);

      return true;
    } on DioError catch (e) {
      print(e.toString());
      print(e.response!.data);
      if (e.response!.statusCode! >= 500) {
        throw "Internal Server Error!";
      } else {
        throw e.response!.statusMessage!;
      }
    } catch (e) {
      print(e.toString());
      throw "Something went wrong!";
    }
  }
}
