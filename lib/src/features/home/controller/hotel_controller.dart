import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orb/src/core/repository/hotel_repository.dart';
import 'package:orb/src/features/home/models/hotel_detail.dart';

import '../models/hotel.dart';

class HotelController extends GetxController {
  final isFeaturedLoading = false.obs;
  final isPopularLoading = false.obs;
  final fetchHotel = false.obs;

  final Rx<List<Hotel>> featured = Rx<List<Hotel>>([]);
  final Rx<List<Hotel>> popular = Rx<List<Hotel>>([]);

  final HotelRepository hotelRepository = HotelRepository();
  Future<void> getFeatured() async {
    try {
      isFeaturedLoading.value = true;
      final response = await hotelRepository.getFeatured();
      if (response != null) {
        isFeaturedLoading.value = false;
        for (var element in response) {
          featured.value.add(element);
        }
        featured.refresh();
      } else {
        isFeaturedLoading.value = false;
        throw "Couldn't Fetch Data.";
      }
    } catch (e) {
      isFeaturedLoading.value = false;
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

  Future<void> getPopular() async {
    try {
      isFeaturedLoading.value = true;
      final response = await hotelRepository.getPopular();
      if (response != null) {
        isFeaturedLoading.value = false;
        for (var element in response) {
          popular.value.add(element);
        }
        popular.refresh();
      } else {
        isFeaturedLoading.value = false;
        throw "Couldn't Fetch Data.";
      }
    } catch (e) {
      isFeaturedLoading.value = false;
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

  Future<HotelDetailModel?> getHotelDetail(
      {required String uri,
      required String checkIn,
      required String checkOut,
      required bool loading}) async {
    try {
      fetchHotel.value = loading;
      final response = await hotelRepository.getHotelDetail(
          checkIn: checkIn, checkOut: checkOut, uri: uri);
      if (response != null) {
        fetchHotel.value = loading ? false : fetchHotel.value;
        return response;
      } else {
        fetchHotel.value = loading ? false : fetchHotel.value;
        throw "Couldn't Fetch Data.";
      }
    } catch (e) {
      fetchHotel.value = loading ? false : fetchHotel.value;
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
