import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:orb/src/core/controller/auth_controller.dart';
import 'package:orb/src/core/repository/hotel_repository.dart';
import 'package:orb/src/features/account/data/model/myBooking.dart';
import 'package:orb/src/features/home/controller/search_controller.dart';
import 'package:orb/src/features/home/models/hotel_detail.dart';

import '../views/checkout.dart';

class BookingController extends GetxController {
  final Rx<ChooseYourRoom?> selectedRoom = Rx<ChooseYourRoom?>(null);
  final fullName = "".obs;
  final email = "".obs;
  final phone = "".obs;
  final hotel = "".obs;
  final bookingId = "".obs;
  final bookingNumber = "".obs;
  final bookingGuID = "".obs;

  final subTotal = (0.0).obs;
  final night = 1.obs;
  final tempSubTotal = (0.0).obs;
  final tempSubTotalBooked = (0.0).obs;
  final extraCharg = (0.0).obs;
  final orderTax = (0.0).obs;
  final orderTotal = (0.0).obs;
  final price = (0.0).obs;
  final feeDiscount = [].obs;
  final feeDiscountBooked = [].obs;
  final onLoyalty = false.obs;
  final usedLoyalty = (0.0).obs;
  final SearchController searchController = Get.find<SearchController>();
  final AuthController authController = Get.find<AuthController>();
  final bookingPaymentDetailsData = {}.obs;
  int get extraAdultsVal =>
      searchController.adults.value -
      int.parse((selectedRoom.value!.maxAdults! * searchController.rooms.value)
          .toString());

  int get nights => searchController.checkOutDate.value
      .difference(searchController.checkinDate.value)
      .inDays;

  double get subTotalValue => double.parse(
      (nights * selectedRoom.value!.minPrice! * searchController.rooms.value)
          .toStringAsFixed(2));
  double get subTotalValueWithExtra => double.parse((subTotalValue +
          ((extraAdultsVal > 0 ? extraAdultsVal : 0) *
              selectedRoom.value!.itemPricePer! *
              nights))
      .toStringAsFixed(2));
  feeOrDiscount() {
    feeDiscount.value = [];
    tempSubTotal.value = subTotalValueWithExtra;
    List<CategoryFeeOrDiscount> tempCat =
        List.from(selectedRoom.value!.categoryFeeOrDiscount ?? []);
    tempCat.sort((a, b) => a.displayOrder!.compareTo(b.displayOrder!));

    for (var e in tempCat) {
      double val = 0;
      if (e.isPercentage == true) {
        val = ((tempSubTotal.value * (e.percentageOrAmount! / 100)) *
            (e.direction!));
      } else {
        val = (tempSubTotal.value + (e.percentageOrAmount! * e.direction!));
      }
      feeDiscount.add({
        "title": e.feeOrDiscountName,
        "percentOrAmount": e.percentageOrAmount,
        "isPercentage": e.isPercentage ?? true,
        "value": val
      });
      tempSubTotal.value = tempSubTotal.value + val;
    }
    if (onLoyalty.value) {
      if (tempSubTotal.value <
          (authController.user.value!.loyaltyPointAmount ?? 0)) {
        usedLoyalty.value = tempSubTotal.value;
      } else {
        usedLoyalty.value =
            (authController.user.value!.loyaltyPointAmount ?? 0);
      }
      tempSubTotal.value = tempSubTotal.value <
              (authController.user.value!.loyaltyPointAmount ?? 0)
          ? 0
          : tempSubTotal.value -
              (authController.user.value!.loyaltyPointAmount ?? 0);
    }
  }

  feeOrDiscountBooked(MyBookingModel myBookingModel) {
    feeDiscountBooked.value = [];
    night.value = myBookingModel.bookingDateTo!
        .difference(myBookingModel.bookingDateFrom!)
        .inDays;
    tempSubTotalBooked.value = myBookingModel.subTotal!.toDouble();
    // List<RoomBookingFeeOrDiscountDto> tempCat =
    //     List.from(myBookingModel.roomBookingFeeOrDiscountDto ?? []);
    // tempCat.sort((a, b) => a.displayOrder!.compareTo(b.displayOrder!));

    // for (var e in tempCat) {
    //   double val = 0;
    //   if (e.isPercentage == true) {
    //     val = ((tempSubTotalBooked.value * (e.percentageOrAmount! / 100)) *
    //         (e.direction!));
    //   } else {
    //     val =
    //         (tempSubTotalBooked.value + (e.percentageOrAmount! * e.direction!));
    //   }
    //   feeDiscountBooked.add({
    //     "title": e.feeOrDiscountName,
    //     "percentOrAmount": e.percentageOrAmount,
    //     "isPercentage": e.isPercentage ?? true,
    //     "value": val
    //   });
    //   tempSubTotalBooked.value = tempSubTotalBooked.value + val;
    // }
  }

  double get extraChrg => double.parse((subTotalValue * .1).toStringAsFixed(2));
  double get orderTaxValue =>
      double.parse(((extraChrg + subTotalValue) * .13).toStringAsFixed(2));
  final isLoading = false.obs;

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

  bookRoomPayment({
    required String? provider,
    required String? currency,
    required String? amount,
    required String? amountInPaisa,
    required String? mobile,
    required String? idx,
    required String? productIdentity,
    required String? productName,
    required String? productUrl,
    required String? token,
  }) async {
    bookingPaymentDetailsData.value = {
      "paymentProviderCode": provider,
      "currencyCode": "NPR",
      "amount": double.parse(amount.toString().replaceAll('.', '.')),
      "amountInPaisa": int.parse(amountInPaisa!) * 100,
      "providerTransactionId": idx,
      "mobile": mobile,
      "productIdentity": productIdentity,
      "productName": productName,
      "prouctUrl": productUrl,
      "token": token,
      "widgetId": "string",
    };
  }

  bookRoomPost() async {
    try {
      isLoading.value = true;
      final res = await HotelRepository().bookHotel(
          customerGuid: authController.user.value!.id ?? "",
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
          subTotal: subTotalValueWithExtra,
          extraCharg: subTotalValueWithExtra - subTotalValue,
          orderTotal: orderTotal.value,
          price: price.value,
          orderTax: orderTax.value,
          itemFeeOrDiscountIds: [
            ...selectedRoom.value!.categoryFeeOrDiscount!
                .map((e) => e.categoryFeeOrDiscountId!)
          ],
          itemGuIds: selectedRoom.value!.availableRoomGuids!
              .split(',')
              .sublist(0, searchController.rooms.value)
              .join(','),
          usedLoyaltyPointAmount: onLoyalty.value ? usedLoyalty.value : 0,
          roomBookingGuid: bookingGuID.value);
      if (res != null) {
        isLoading.value = false;
        bookingId.value = res['bookingID'].toString();
        bookingNumber.value = res['bookingNumber'].toString();
        bookingGuID.value = res['bookingGuID'];
        // Get.off(PaymentMethods());
        // Get.to(CheckOutPage());
        bookRoomPostPayment();
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

  bookRoomPostPayment(
      {String? transactionId,
      String? transactionGuId,
      MyBookingModel? myBookingModel}) async {
    try {
      isLoading.value = true;
      final res = await HotelRepository().bookHotelPayment(paymentProvider: {
        ...bookingPaymentDetailsData,
        "paymentForTransactionId": transactionId ?? bookingId.value,
        "paymentForTransactionGuId": transactionGuId ?? bookingGuID.value
      });
      if (res != null) {
        isLoading.value = false;

        Get.to(CheckOutPage(paid: true, myBookingModel: myBookingModel));
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
