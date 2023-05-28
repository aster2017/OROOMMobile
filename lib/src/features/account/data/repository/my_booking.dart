import 'package:get/get.dart';
import 'package:orb/src/core/controller/auth_controller.dart';
import 'package:orb/src/features/account/data/model/myBooking.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/services/dio_service.dart';
import '../model/loyalty_earning.dart';
import '../model/loyalty_used.dart';

class BookingRepository {
  AuthController authController = Get.find<AuthController>();
  Future<Map<String, dynamic>?> getMyBookings() async {
    try {
      final response = await DioService().client.get(
            "${APIEndpoints.myBooking}/${authController.user.value!.id}",
          );
      return {
        "myBookings": myBookingModelFromJson(response.data['myBookings']),
        "loyaltyPointUsage":
            loyaltyUsedFromJson(response.data['loyaltyPointUsage']),
        "loyaltyPointEarnings":
            loyaltyEarningsFromJson(response.data['loyaltyPointEarnings']),
      };
    } on DioError catch (e) {
      if (e.response!.statusCode! >= 500) {
        throw "Internal Server Error!";
      } else {
        throw e.response!.statusMessage!;
      }
    } catch (e) {
      print(e.toString() + " error here");
      throw "Something went wrong!";
    }
  }
}
