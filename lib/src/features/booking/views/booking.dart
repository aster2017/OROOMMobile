import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/core/constants/colors.dart';
import 'package:orb/src/core/ui/bookingDates.dart';
import 'package:orb/src/core/ui/bookingDetails.dart';
import 'package:orb/src/core/ui/textfield.dart';
import 'package:orb/src/features/booking/views/payment_methods.dart';
import 'package:orb/src/features/home/controller/search_controller.dart';
import 'package:orb/src/features/signup/views/signup.dart';

import '../controller/bookingController.dart';

class BookPage extends StatefulWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final BookingController bookingController = Get.find<BookingController>();
  final SearchController searchController = Get.find<SearchController>();

  TextEditingController fullNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int adults = 0;
  int childrens = 0;
  bool showGuests = false;
  int get subTotal =>
      bookingController.nights *
      bookingController.selectedRoom.value!.minPrice!;
  double get extraChrg => subTotal * .1;
  double get orderTax => (extraChrg + subTotal) * .13;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: textPrimary),
        title: Text(
          "Booking",
          style: GoogleFonts.mulish(
              color: textPrimary, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              height: 2,
              color: Color(0xfff2f2f2),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          KTextFormField(
                            label: "",
                            hint: "Full Name",
                            controller: fullNameCtrl,
                            isFilled: true,
                            validator: ((p0) => p0 == null || p0.isEmpty
                                ? "Enter Valid value"
                                : null),
                          ),
                          KTextFormField(
                            label: "",
                            hint: "Email",
                            controller: emailCtrl,
                            isFilled: true,
                            validator: ((p0) => p0 == null || p0.isEmpty
                                ? "Enter Valid value"
                                : null),
                          ),
                          KTextFormField(
                            label: "",
                            hint: "Phone number",
                            controller: phoneCtrl,
                            isFilled: true,
                            validator: ((p0) => p0 == null || p0.isEmpty
                                ? "Enter Valid value"
                                : null),
                          ),
                        ],
                      ),
                    ),
                    BookingDatesRow(),
                    SizedBox(
                      height: 12.h,
                    ),
                    BookingDetailsRow(),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                      "Payment Details",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.mulish(
                          color: textPrimary,
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                          height: 1.2),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Divider(
                      height: 2,
                      color: Color(0xff4f4f4f),
                    ),
                    detailsRow(
                        bookingController.selectedRoom.value!.roomCategory!,
                        "${searchController.rooms.value} Room  x ${bookingController.nights} nights",
                        "$subTotal"),
                    // detailsRow("Security Deposit", null, "100.00"),
                    detailsRow("10% Service Charge", null, "$extraChrg"),
                    detailsRow("13% VAT", null, "$orderTax"),
                    Divider(
                      height: 2,
                      color: Color(0xff4f4f4f),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Grand Total",
                            style: GoogleFonts.mulish(
                                fontWeight: FontWeight.w400,
                                fontSize: 18.sp,
                                height: 1.3,
                                color: textPrimary),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "NPR ",
                                style: GoogleFonts.mulish(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    height: 1.3,
                                    color: textPrimary),
                              ),
                              Text(
                                "${subTotal + orderTax + extraChrg}",
                                style: GoogleFonts.mulish(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.sp,
                                    height: 1.3,
                                    color: primaryColor),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.w),
                          color: Color(0xff82C141).withOpacity(.2)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Creat an account",
                              style: GoogleFonts.mulish(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  height: 1.3,
                                  color: textPrimary),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Create an account for discounts and offers.",
                                  style: GoogleFonts.mulish(
                                      fontWeight: FontWeight.w400,
                                      color: textPrimary,
                                      fontSize: 14.sp,
                                      height: 1.2),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.offAll(SignupPage());
                                  },
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      alignment: Alignment.center),
                                  child: Text(
                                    "Sign In",
                                    style: GoogleFonts.mulish(
                                        color: primaryColor,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            if (!formKey.currentState!.validate()) {
                              return;
                            }
                            bookingController.bookRoom(
                                subTotalVal: subTotal.toDouble(),
                                extraChargVal: extraChrg,
                                orderTaxVal: orderTax,
                                orderTotalVal: subTotal + orderTax + extraChrg,
                                priceVal: 0,
                                emailVal: emailCtrl.text,
                                name: fullNameCtrl.text,
                                phoneVal: phoneCtrl.text);
                            Get.to(PaymentMethods());
                          },
                          child: Container(
                            width: 170.w,
                            height: 44.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                color: primaryColor),
                            child: Center(
                              child: Text(
                                "Complete Booking",
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
                )),
          ],
        ),
      ),
    );
  }

  Widget detailsRow(String title, String? desc, String val) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.mulish(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    height: 1.3,
                    color: textPrimary),
              ),
              desc == null
                  ? Container()
                  : Text(
                      desc,
                      style: GoogleFonts.mulish(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          height: 1.3,
                          color: primaryColor),
                    ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "NPR ",
                style: GoogleFonts.mulish(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    height: 1.3,
                    color: textPrimary),
              ),
              Text(
                val,
                style: GoogleFonts.mulish(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                    height: 1.3,
                    color: textPrimary),
              ),
            ],
          )
        ],
      ),
    );
  }
}
