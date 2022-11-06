import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/core/authentication_manager.dart';
import 'package:orb/src/core/constants/colors.dart';
import 'package:orb/src/core/controller/auth_controller.dart';
import 'package:orb/src/core/ui/bookingDates.dart';
import 'package:orb/src/core/ui/bookingDetails.dart';
import 'package:orb/src/core/ui/textfield.dart';
import 'package:orb/src/features/booking/views/payment_methods.dart';
import 'package:orb/src/features/home/controller/search_controller.dart';
import 'package:orb/src/features/login/views/login.dart';

import '../controller/bookingController.dart';

class BookPage extends StatefulWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final BookingController bookingController = Get.find<BookingController>();
  final SearchController searchController = Get.find<SearchController>();
  final AuthController authController = Get.find<AuthController>();
  final AuthenticationManager authenticationManager =
      Get.find<AuthenticationManager>();

  TextEditingController fullNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int adults = 0;
  int childrens = 0;
  bool showGuests = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullNameCtrl.text =
        "${authController.user.value!.firstName ?? ""} ${authController.user.value!.lastName ?? ""}";
    emailCtrl.text = authController.user.value!.email ?? "";
    phoneCtrl.text = authController.user.value!.phoneNumber ?? "";
  }

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
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              Divider(
                height: 2,
                color: Color(0xfff2f2f2),
              ),
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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
                      BookingDatesRow(changeDate: false),
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
                          "${bookingController.subTotalValue}"),
                      // detailsRow("Security Deposit", null, "100.00"),
                      detailsRow("10% Service Charge", null,
                          "${bookingController.extraChrg}"),
                      detailsRow("13% VAT", null,
                          "${bookingController.orderTaxValue}"),
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
                                  "${bookingController.subTotalValue + bookingController.orderTaxValue + bookingController.extraChrg}",
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
                      authenticationManager.isLogged.value
                          ? Container()
                          : Container(
                              padding: EdgeInsets.all(20.w),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.w),
                                  color: Color(0xff82C141).withOpacity(.2)),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Login to account",
                                      style: GoogleFonts.mulish(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp,
                                          height: 1.3,
                                          color: textPrimary),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Wrap(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,

                                      children: [
                                        Text(
                                          "Login to account for discounts and offers.",
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w400,
                                              color: textPrimary,
                                              fontSize: 14.sp,
                                              height: 1.2),
                                        ),
                                        MediaQuery.removePadding(
                                          context: context,
                                          removeTop: true,
                                          removeBottom: true,
                                          child: TextButton(
                                            onPressed: () {
                                              Get.offAll(LoginPage(
                                                isBooking: true,
                                              ));
                                            },
                                            style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                tapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                alignment: Alignment.center),
                                            child: Text(
                                              "Sign In",
                                              style: GoogleFonts.mulish(
                                                  color: primaryColor,
                                                  decoration:
                                                      TextDecoration.underline),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Center(
                            child: searchController.rooms.value >
                                    bookingController
                                        .selectedRoom.value!.noOfRooms!
                                ? Text(
                                    "Sorry only ${bookingController.selectedRoom.value!.noOfRooms!} rooms is avilable at given time.",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.mulish(
                                        color: redColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        height: 1.4))
                                : buttonWidget()),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector buttonWidget() {
    return GestureDetector(
      onTap: () {
        if (!formKey.currentState!.validate()) {
          return;
        }
        bookingController.bookRoom(
            subTotalVal: bookingController.subTotalValue.toDouble(),
            extraChargVal: bookingController.extraChrg,
            orderTaxVal: bookingController.orderTaxValue,
            orderTotalVal: bookingController.subTotalValue +
                bookingController.orderTaxValue +
                bookingController.extraChrg,
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
            borderRadius: BorderRadius.circular(10.w), color: primaryColor),
        child: Center(
          child: Text(
            "Complete Booking",
            style: GoogleFonts.mulish(
                color: whiteColor, height: 1.4, fontSize: 16.sp),
          ),
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
