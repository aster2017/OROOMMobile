import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orb/src/features/account/data/model/myBooking.dart';
import 'package:orb/src/features/account/data/repository/my_booking.dart';

class MyBookingController extends GetxController {
  final isLoading = false.obs;

  final Rx<List<MyBookingModel>> bookings = Rx<List<MyBookingModel>>([]);

  Future<void> getBookings() async {
    try {
      isLoading.value = true;
      final response = await BookingRepository().getMyBookings();
      if (response != null) {
        isLoading.value = false;
        for (var element in response) {
          bookings.value.add(element);
        }
        bookings.refresh();
      } else {
        isLoading.value = false;
        throw "Couldn't Fetch Data.";
      }
    } catch (e) {
      isLoading.value = false;
      Get.showSnackbar(GetSnackBar(
        title: "Error!",
        message: e.toString(),
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(10),
        borderRadius: 20,
      ));
    }
  }
}
