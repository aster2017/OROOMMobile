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

import '../../../core/ui/loading.dart';
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
    super.initState();
    bookingController.feeOrDiscount();
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
        () => Stack(
          children: [
            mainBody(),
            bookingController.isLoading.value ? LoadingOverlay() : Container()
          ],
        ),
      ),
    );
  }

  Widget mainBody() {
    return SingleChildScrollView(
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
                          validator: (value) {
                            RegExp regex =
                                RegExp(r"^[a-zA-Z]{2,}(?: [a-zA-Z]+){0,2}$");
                            return regex.hasMatch(value!.trim())
                                ? null
                                : "Enter valid Name";
                          },
                        ),
                        KTextFormField(
                            label: "",
                            hint: "Email",
                            controller: emailCtrl,
                            isFilled: true,
                            validator: (value) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value!)
                                  ? null
                                  : "Enter valid Email";
                            }),
                        KTextFormField(
                          label: "",
                          hint: "Phone number",
                          controller: phoneCtrl,
                          isFilled: true,
                          validator: (p0) => (p0 == null || p0.isEmpty)
                              ? "Enter Valid value"
                              : null,
                        ),
                      ],
                    ),
                  ),
                  BookingDatesRow(changeDate: false),
                  SizedBox(
                    height: 12.h,
                  ),
                  BookingDetailsRow(
                    isBookPage: true,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  if (authController.user.value!.loyaltyPointAmount != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(
                          height: 2,
                          color: Color(0xff4f4f4f),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Text(
                          "B&F Promotions",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.mulish(
                              color: textPrimary,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                              height: 1.2),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Use Loyalty Point",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.mulish(
                                  color: textPrimary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  height: 1.2),
                            ),
                            Row(children: [
                              Text(
                                "- RS. ",
                                style: GoogleFonts.mulish(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    height: 1.3,
                                    color: textPrimary),
                              ),
                              Text(
                                bookingController.onLoyalty.value
                                    ? bookingController.usedLoyalty.value
                                        .toStringAsFixed(2)
                                    : bookingController.tempSubTotal <
                                            (double.tryParse(authController.user
                                                    .value!.loyaltyPointAmount
                                                    .toString()) ??
                                                0)
                                        ? bookingController.tempSubTotal
                                            .toStringAsFixed(2)
                                        : double.tryParse(authController
                                                .user.value!.loyaltyPointAmount
                                                .toString())!
                                            .toStringAsFixed(2),
                                // "26.00",
                                style: GoogleFonts.mulish(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.sp,
                                    height: 1.3,
                                    color: textPrimary),
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Switch(
                                value: bookingController.onLoyalty.value,
                                onChanged: (value) {
                                  bookingController.onLoyalty.value = value;
                                  bookingController.feeOrDiscount();
                                },
                                activeTrackColor: secondaryColor,
                                activeColor: Colors.white,
                              ),
                            ])
                          ],
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Divider(
                          height: 2,
                          color: Color(0xff4f4f4f),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                      ],
                    ),
                  // : Container(),
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
                  bookingController.extraAdultsVal > 0
                      ? detailsRow(
                          "",
                          "${bookingController.extraAdultsVal} Extra Adults  x ${bookingController.nights} nights",
                          "${bookingController.subTotalValueWithExtra - bookingController.subTotalValue}")
                      : Container(),
                  ...bookingController.feeDiscount.map(
                    (e) => detailsRow(
                        e['title'],
                        e['isPercentage'] ? "${e['percentOrAmount']} %" : null,
                        "${e['value']}"),
                  ),
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
                              "RS. ",
                              style: GoogleFonts.mulish(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  height: 1.3,
                                  color: textPrimary),
                            ),
                            Text(
                              double.parse(
                                      (bookingController.tempSubTotal.value)
                                          .toString())
                                  .toStringAsFixed(2),
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Center(
                        child: searchController.rooms.value >
                                bookingController.selectedRoom.value!.noOfRooms!
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
            priceVal:
                bookingController.selectedRoom.value?.minPrice!.toDouble() ?? 0,
            emailVal: emailCtrl.text,
            name: fullNameCtrl.text,
            phoneVal: phoneCtrl.text);
        // bookingController.bookRoomPost();
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

  Widget detailsRow(String? title, String? desc, String val) {
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
              title == null
                  ? Container()
                  : Text(
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
                "RS. ",
                style: GoogleFonts.mulish(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    height: 1.3,
                    color: textPrimary),
              ),
              Text(
                double.parse(val.toString()).toStringAsFixed(2),
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
