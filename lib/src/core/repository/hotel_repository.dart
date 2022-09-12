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

  Future<HotelDetailModel?> bookHotel({
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
      final tokenResponse =
          await DioService().client.post(APIEndpoints.booking, data: {
        "branchUri": hotelUri,
        "categoryID": room.roomCategoryId,
        "itemID": room.roomCategoryId,
        "firstName": name.split(' ').first,
        "lastName": name.split(' ').length >= 2 ? name.split(' ').last : name,
        "phone": phone,
        "email": "user@example.com",
        "password": "string",
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
        "paymentTypeID": 0,
        "ipAddress": "string",
        "customerID": 0,
        "customerGuid": "",
        "userId": "",
        "paymentProvider": paymentProvider
      });

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
}
