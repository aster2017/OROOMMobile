import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/features/booking/controller/bookingController.dart';
import 'package:orb/src/features/booking/views/checkout.dart';

import 'package:khalti_flutter/khalti_flutter.dart';

import '../../../core/constants/colors.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({Key? key}) : super(key: key);

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  final BookingController bookingController = Get.find<BookingController>();
  List<Map<String, dynamic>> currencies = [
    {"title": "NPR", "flag": "flags/np.png"},
    {"title": "USD", "flag": "flags/us.png"},
  ];
  List<Map<String, dynamic>> paymentMethods = [
    {"title": "eSewa Mobile Wallet", "logo": "assets/icons/esewa.png"},
    {"title": "Khalti Digital Wallet", "logo": "assets/icons/khalti.png"},
    {"title": "Pay at Check In", "logo": "assets/icons/payCheck.png"},
  ];
  Map<String, dynamic>? selectedCurrency;
  Map<String, dynamic>? selectedPaymentMethod;
  @override
  void initState() {
    super.initState();
    selectedCurrency = currencies[0];
    selectedPaymentMethod = paymentMethods[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: textPrimary),
        title: Text(
          "Payment Method",
          style: GoogleFonts.mulish(
              color: textPrimary, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        Divider(
          height: 2,
          color: Color(0xfff2f2f2),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Please select a Payment Method",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.mulish(
                          color: textPrimary,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          height: 1.2),
                    ),
                    Container(
                      width: 100.w,
                      height: 38.h,
                      // padding: EdgeInsets.symmetric(
                      //     horizontal: 20.w, vertical: 14.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.h),
                          border: Border.all(color: textPrimary)),
                      padding: EdgeInsets.all(6.w),
                      child: DropdownButton<Map<String, dynamic>>(
                        underline: Container(),
                        value: selectedCurrency,
                        isExpanded: true,
                        items: [
                          ...currencies.map((e) => DropdownMenuItem(
                                value: e,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      e['flag'],
                                      package: 'country_code_picker',
                                      width: 17.sp,
                                      height: 17.sp,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      e['title'],
                                      style: GoogleFonts.workSans(
                                          color: textPrimary,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          height: 1.2),
                                    ),
                                  ],
                                ),
                              ))
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedCurrency = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                Expanded(
                  child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: ((context, index) =>
                              paymentMethodsWidget(index)),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 10.h,
                              ),
                          itemCount: paymentMethods.length)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(CheckOutPage());
                      },
                      child: Container(
                        width: 170.w,
                        height: 44.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.w),
                            color: primaryColor),
                        child: Center(
                          child: Text(
                            "Continue",
                            style: GoogleFonts.mulish(
                                color: whiteColor,
                                height: 1.4,
                                fontSize: 16.sp),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget paymentMethodsWidget(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = paymentMethods[index];
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.w),
        child: Container(
            margin: EdgeInsets.all(10.w),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color(0xff00A5F4).withOpacity(.25), blurRadius: 10)
              ],
              borderRadius: BorderRadius.circular(10.w),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      paymentMethods[index]['logo'],
                      width: 34.w,
                      height: 34.w,
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Text(
                      paymentMethods[index]['title'],
                      textAlign: TextAlign.left,
                      style: GoogleFonts.mulish(
                          color: textPrimary,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          height: 1.2),
                    ),
                  ],
                ),
                Container(
                  width: 16.w,
                  height: 16.w,
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 2, color: primaryColor)),
                  child: selectedPaymentMethod == paymentMethods[index]
                      ? Center(
                          child: Container(
                              width: 12.w,
                              height: 12.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: primaryColor)),
                        )
                      : Container(),
                )
              ],
            )),
      ),
    );
  }

  void khaltiPayment() async {
    final config = PaymentConfig(
      amount: (bookingController.orderTotal * 100)
          .toInt(), // Amount should be in paisa
      productIdentity: bookingController.selectedRoom.value!.roomCategoryUri!,
      productName:
          'Room Booking ${bookingController.selectedRoom.value!.roomCategory!}',
      productUrl: 'https://www.khalti.com/#/bazaar',
    );

    KhaltiScope.of(context).pay(
      config: config,
      preferences: [
        PaymentPreference.khalti,
        PaymentPreference.eBanking,
        PaymentPreference.mobileBanking,
        PaymentPreference.connectIPS,
        PaymentPreference.sct
      ],
      onSuccess: (value) {
        bookingController.bookRoomPost(value);
      },
      onFailure: (value) {
        print(value.data);
      },
      onCancel: () {
        print("value.data");
      },
    );
  }
}
