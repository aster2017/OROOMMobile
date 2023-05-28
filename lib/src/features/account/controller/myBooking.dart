import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orb/src/features/account/data/model/loyalty_earning.dart';
import 'package:orb/src/features/account/data/model/loyalty_used.dart';
import 'package:orb/src/features/account/data/model/myBooking.dart';
import 'package:orb/src/features/account/data/repository/my_booking.dart';

class MyBookingController extends GetxController {
  final isLoading = false.obs;

  final Rx<List<MyBookingModel>> bookings = Rx<List<MyBookingModel>>([]);
  final Rx<List<LoyaltyEarnings>> loyaltyEarnings =
      Rx<List<LoyaltyEarnings>>([]);
  final Rx<List<LoyaltyUsed>> loyaltyUsed = Rx<List<LoyaltyUsed>>([]);

  Future<void> getBookings() async {
    try {
      isLoading.value = true;
      bookings.value.clear();
      final responseAll = await BookingRepository().getMyBookings();
      final response = responseAll!['myBookings'];
      final responseEarnings = responseAll['loyaltyPointEarnings'];
      final responseUsage = responseAll['loyaltyPointUsage'];

      for (var element in response) {
        bookings.value.add(element);
      }
      bookings.value = [...bookings.value.reversed];
      bookings.refresh();
      for (var element in responseEarnings) {
        loyaltyEarnings.value.add(element);
      }
      loyaltyEarnings.value = [...loyaltyEarnings.value.reversed];
      loyaltyEarnings.refresh();
      for (var element in responseUsage) {
        loyaltyUsed.value.add(element);
      }
      loyaltyUsed.value = [...loyaltyUsed.value.reversed];
      loyaltyUsed.refresh();
      isLoading.value = false;
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
