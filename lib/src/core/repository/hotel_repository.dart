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
      return hotelDetailModelFromJson(tokenResponse.data);
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

  Future<Map<String, dynamic>?> bookHotel({
    required String customerGuid,
    required String name,
    required String email,
    required String phone,
    required String checkIn,
    required String checkOut,
    required String hotelUri,
    required String childsAge,
    required String itemGuIds,
    required List<int> itemFeeOrDiscountIds,
    required double usedLoyaltyPointAmount,
    required ChooseYourRoom room,
    required int noOfRooms,
    required int noOfNights,
    required double subTotal,
    required int noOfAdults,
    required double extraCharg,
    required double orderTotal,
    required double price,
    required double orderTax,
    // required Map<String, dynamic> paymentProvider,
  }) async {
    try {
      final data = {
        "customerGuid": customerGuid,
        "branchUri": hotelUri,
        "categoryID": room.roomCategoryId,
        "itemID": room.roomCategoryId,
        "itemGuID": itemGuIds.split(',').length > 1
            ? itemGuIds.split(',').first
            : itemGuIds,
        "itemGuIDs": itemGuIds,
        "firstName": name.split(' ').first,
        "lastName": name.split(' ').length >= 2 ? name.split(' ').last : name,
        "phone": phone.replaceAll("+977", ""),
        "email": email,
        "address": "",
        // "password": null,
        "price": price,
        "noOfRooms": noOfRooms,
        "noOfNights": noOfNights,
        "subTotal": subTotal,
        "noOfAdults": noOfAdults,
        "childAges": "0",
        "orderTax": orderTax,
        "extraCharge": extraCharg.toString(),
        "orderTotal": orderTotal.toStringAsFixed(2),
        "checkInDate": checkIn,
        "checkOutDate": checkOut,
        "paymentTypeID": 1,
        "ipAddress": "27.34.24.23",
        "customerID": 0,
        "itemFeeOrDiscountIds": itemFeeOrDiscountIds,
        "usedLoyaltyPointAmount": usedLoyaltyPointAmount.toString(),
        "userId": customerGuid
        // "paymentProvider": paymentProvider
      };
      print(jsonEncode(data));
      final response =
          await DioService().client.post(APIEndpoints.booking, data: data);

      return response.data!['data'];
    } on DioError catch (e) {
      print(e.toString());
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

  Future<String?> bookHotelPayment({
    required Map<String, dynamic> paymentProvider,
  }) async {
    try {
      ;
      final response = await DioService()
          .client
          .post(APIEndpoints.bookingPayment, data: paymentProvider);

      return response.data!;
    } on DioError catch (e) {
      print(e.toString());
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

  Future<bool?> postReview({
    required String firstName,
    required String lastName,
    required String hotelUri,
    required int rating,
    required String review,
    required String email,
  }) async {
    try {
      await DioService().client.post(APIEndpoints.review, queryParameters: {
        "IpAddress": "192.168.0.1"
      }, data: {
        "firstName": firstName,
        "lastName": lastName,
        "hotelUri": hotelUri,
        "createdDate": "${DateTime.now().toIso8601String()}Z",
        "rating": rating,
        "review": review,
        "email": email,
      });
      return true;
    } on DioError catch (e) {
      if (e.response!.statusCode! >= 500) {
        throw "Internal Server Error!";
      } else {
        print(e.response!.data);
        throw e.response!.statusMessage!;
      }
    } catch (e) {
      print(e.toString());
      throw "Something went wrong!";
    }
  }
}
