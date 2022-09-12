import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:orb/src/core/repository/hotel_repository.dart';
import 'package:orb/src/features/home/controller/search_controller.dart';
import 'package:orb/src/features/home/models/hotel_detail.dart';
import 'package:orb/src/features/hotelDetail/views/hotel_detail.dart';

class BookingController extends GetxController {
  final Rx<ChooseYourRoom?> selectedRoom = Rx<ChooseYourRoom?>(null);
  final fullName = "".obs;
  final email = "".obs;
  final phone = "".obs;
  final hotel = "".obs;

  final subTotal = (0.0).obs;
  final extraCharg = (0.0).obs;
  final orderTax = (0.0).obs;
  final orderTotal = (0.0).obs;
  final price = (0.0).obs;
  final SearchController searchController = Get.find<SearchController>();
  int get nights => searchController.checkOutDate.value
      .difference(searchController.checkinDate.value)
      .inDays;

  bookRoom({
    required String name,
    required String emailVal,
    required String phoneVal,
    required double subTotalVal,
    required double extraChargVal,
    required double orderTaxVal,
    required double orderTotalVal,
    required double priceVal,
  }) async {
    fullName.value = name;
    email.value = emailVal;
    phone.value = phoneVal;
    subTotal.value = subTotalVal;
    extraCharg.value = extraChargVal;
    orderTotal.value = orderTotalVal;
    price.value = priceVal;
    orderTax.value = orderTaxVal;
  }

  bookRoomPost(PaymentSuccessModel payment) async {
    try {
      final res = await HotelRepository().bookHotel(
          name: fullName.value,
          email: email.value,
          phone: phone.value,
          checkIn: DateFormat("yyyy-MM-dd")
              .format(searchController.checkinDate.value),
          checkOut: DateFormat("yyyy-MM-dd")
              .format(searchController.checkOutDate.value),
          childsAge: "",
          room: selectedRoom.value!,
          noOfRooms: searchController.rooms.value,
          noOfNights: nights,
          noOfAdults: searchController.adults.value,
          hotelUri: hotel.value,
          subTotal: subTotal.value,
          extraCharg: extraCharg.value,
          orderTotal: orderTotal.value,
          price: price.value,
          orderTax: orderTax.value,
          paymentProvider: {
            "paymentProviderCode": "KHALTI",
            "currencyCode": "NPR",
            "amount": payment.amount,
            "amountInPaisa": payment.amount / 100,
            "providerTransactionId": payment.idx,
            "mobile": payment.mobile,
            "productIdentity": payment.productIdentity,
            "productName": payment.productName,
            "prouctUrl": payment.productUrl,
            "token": payment.token,
            "widgetId": "string"
          });
    } catch (e) {}
  }
}
