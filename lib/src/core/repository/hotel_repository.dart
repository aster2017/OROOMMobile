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
}
