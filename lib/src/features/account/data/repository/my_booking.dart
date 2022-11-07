import 'package:get/get.dart';
import 'package:orb/src/core/controller/auth_controller.dart';
import 'package:orb/src/features/account/data/model/myBooking.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/services/dio_service.dart';

class BookingRepository {
  AuthController authController = Get.find<AuthController>();
  Future<List<MyBookingModel>?> getMyBookings() async {
    try {
      final tokenResponse = await DioService().client.get(
            "${APIEndpoints.myBooking}/${authController.user.value!.id}",
          );
      return myBookingModelFromJson(tokenResponse.data);
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
