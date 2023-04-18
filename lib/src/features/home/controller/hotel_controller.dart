import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orb/src/core/controller/auth_controller.dart';
import 'package:orb/src/core/repository/hotel_repository.dart';
import 'package:orb/src/features/home/models/hotel_detail.dart';
import 'package:orb/src/features/home/models/hotel_search.dart';
import 'package:orb/src/features/hotelDetail/widgets/post_review.dart';

import '../../search/views/search_result.dart';
import '../models/hotel.dart';

class HotelController extends GetxController {
  final isFeaturedLoading = false.obs;
  final isPopularLoading = false.obs;
  final fetchHotel = false.obs;
  final postReview = false.obs;

  final Rx<List<Hotel>> featured = Rx<List<Hotel>>([]);
  final Rx<List<Hotel>> popular = Rx<List<Hotel>>([]);
  final Rx<List<HotelSearch>> search = Rx<List<HotelSearch>>([]);

  final HotelRepository hotelRepository = HotelRepository();

  final AuthController authController = Get.find<AuthController>();
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

  Future<void> getSearch(
      {required String string,
      required String location,
      required double minPrice,
      required double maxPrice,
      required String checkIn,
      required String checkOut,
      bool isSearched = false}) async {
    try {
      final response = await hotelRepository.getSearchHotel(
        string: string,
        location: location,
        minPrice: minPrice,
        maxPrice: maxPrice,
        checkIn: checkIn,
        checkOut: checkOut,
      );
      if (response != null) {
        search.value.clear();
        final hotels = hotelSearchFromJson(response.data);
        for (var element in hotels) {
          search.value.add(element);
        }
        search.refresh();
        if (!isSearched) Get.to(SearchResultPage());
      } else {
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

  Future<bool?> postReviewData(
      {required String hotelUri,
      required int rating,
      required String review}) async {
    try {
      postReview.value = true;
      final response = await hotelRepository.postReview(
          firstName: authController.user.value!.firstName!,
          lastName: authController.user.value!.lastName!,
          hotelUri: hotelUri,
          rating: rating,
          review: review,
          email: authController.user.value!.email!);
      if (response != null) {
        postReview.value = false;
        return true;
      } else {
        postReview.value = false;
        throw "Couldn't Fetch Data.";
      }
    } catch (e) {
      postReview.value = false;
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
    return null;
  }
}
