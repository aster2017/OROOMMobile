import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:orb/src/features/account/data/model/myBooking.dart';
import 'package:orb/src/features/booking/controller/bookingController.dart';
import 'package:orb/src/features/booking/views/invoice.dart';
import 'package:orb/src/features/booking/views/successful.dart';
import 'package:orb/src/features/home/controller/search_controller.dart';

import '../../../core/constants/colors.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key, this.paid = false, this.myBookingModel})
      : super(key: key);
  final bool paid;
  final MyBookingModel? myBookingModel;
  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final BookingController bookingController = Get.find<BookingController>();
  final SearchController searchController = Get.find<SearchController>();
  @override
  void initState() {
    if (widget.myBookingModel != null) {
      bookingController.feeOrDiscountBooked(widget.myBookingModel!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: textPrimary),
        title: Text(
          "Check Out",
          style: GoogleFonts.mulish(
              color: textPrimary, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Divider(
            height: 2,
            color: Color(0xfff2f2f2),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Booking Details",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.mulish(
                          color: textPrimary,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          height: 1.2),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.w),
                          color: Color(0xffF2F2F2).withOpacity(.5)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              bookingDetailItem(
                                  "Booking ID",
                                  widget.myBookingModel != null
                                      ? widget.myBookingModel!.bookingNumber!
                                      : bookingController.bookingNumber.value),
                              bookingDetailItem(
                                  "Name",
                                  widget.myBookingModel != null
                                      ? widget.myBookingModel!.firstname!
                                      : bookingController.fullName.value),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              bookingDetailItem(
                                  "Email",
                                  widget.myBookingModel != null
                                      ? widget.myBookingModel!.emailId!
                                      : bookingController.email.value),
                              bookingDetailItem(
                                  "Phone",
                                  widget.myBookingModel != null
                                      ? widget.myBookingModel!.mobileNo!
                                      : bookingController.phone.value),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              bookingDetailItem(
                                  "Check In",
                                  DateFormat.yMMMd().format(widget
                                              .myBookingModel !=
                                          null
                                      ? widget.myBookingModel!.bookingDateFrom!
                                      : searchController.checkinDate.value)),
                              bookingDetailItem(
                                  "Check Out",
                                  DateFormat.yMMMd().format(widget
                                              .myBookingModel !=
                                          null
                                      ? widget.myBookingModel!.bookingDateTo!
                                      : searchController.checkOutDate.value)),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              bookingDetailItem("Nights",
                                  "${widget.myBookingModel != null ? bookingController.nights : bookingController.night.value} Nights"),
                              bookingDetailItem("Room",
                                  "${widget.myBookingModel != null ? widget.myBookingModel!.noOfRooms! : searchController.rooms.value} Rooms"),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              bookingDetailItem("Guest",
                                  "${widget.myBookingModel != null ? widget.myBookingModel!.noOfAdults : searchController.adults.value} Adults ${widget.myBookingModel != null ? widget.myBookingModel!.childAges!.split(",").length : searchController.childrens.value} Children"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                      "Payment Details",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.mulish(
                          color: textPrimary,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          height: 1.2),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.w),
                          color: Color(0xffF2F2F2).withOpacity(.5)),
                      child: Column(
                        children: [
                          detailsRow(
                              "${widget.myBookingModel == null ? bookingController.selectedRoom.value!.roomCategory : widget.myBookingModel!.categoryName!}",
                              "${widget.myBookingModel == null ? searchController.rooms.value : widget.myBookingModel!.noOfRooms} Room  x ${widget.myBookingModel == null ? bookingController.nights : bookingController.night.value} nights",
                              double.parse((widget.myBookingModel == null
                                          ? bookingController.subTotalValue
                                          : widget.myBookingModel!.subTotal)
                                      .toString())
                                  .toStringAsFixed(2)),
                          if (widget.myBookingModel == null)
                            ...bookingController.feeDiscount.map(
                              (e) => detailsRow(
                                  e['title'],
                                  e['isPercentage']
                                      ? "${e['percentOrAmount']} %"
                                      : null,
                                  "${e['value']}"),
                            )
                          else
                            ...bookingController.feeDiscountBooked.map(
                              (e) => detailsRow(
                                  e['title'],
                                  e['isPercentage']
                                      ? "${e['percentOrAmount']} %"
                                      : null,
                                  "${e['value']}"),
                            ),
                          detailsRow(
                              "Grand Total",
                              null,
                              double.parse((widget.myBookingModel == null
                                          ? bookingController.tempSubTotal.value
                                          : bookingController
                                              .tempSubTotalBooked.value)
                                      .toString())
                                  .toStringAsFixed(2)),
                          Divider(
                            height: 2,
                            color: Color(0xff4f4f4f),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(vertical: 8.h),
                          //   child: Row(
                          //     mainAxisSize: MainAxisSize.max,
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text(
                          //         "Total Payable Amount",
                          //         style: GoogleFonts.mulish(
                          //             fontWeight: FontWeight.w400,
                          //             fontSize: 18.sp,
                          //             height: 1.3,
                          //             color: textPrimary),
                          //       ),
                          //       Row(
                          //         crossAxisAlignment: CrossAxisAlignment.end,
                          //         children: [
                          //           Text(
                          //             "RS. ",
                          //             style: GoogleFonts.mulish(
                          //                 fontWeight: FontWeight.w500,
                          //                 fontSize: 14.sp,
                          //                 height: 1.3,
                          //                 color: textPrimary),
                          //           ),
                          //           Text(
                          //             "0.00",
                          //             style: GoogleFonts.mulish(
                          //                 fontWeight: FontWeight.w700,
                          //                 fontSize: 16.sp,
                          //                 height: 1.3,
                          //                 color: primaryColor),
                          //           ),
                          //         ],
                          //       )
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {
                            await CreatePdf(
                                    myBookingModel: widget.myBookingModel)
                                .generateInvoice();
                          },
                          child: Container(
                            width: 170.w,
                            height: 44.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                color: primaryColor),
                            child: Center(
                              child: Text(
                                "Download Receipt",
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
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(SuccessfulPage());
                          },
                          child: Container(
                            width: 170.w,
                            height: 44.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                border: Border.all(color: primaryColor)),
                            child: Center(
                              child: Text(
                                "Continue",
                                style: GoogleFonts.mulish(
                                    color: primaryColor,
                                    height: 1.4,
                                    fontSize: 16.sp),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget bookingDetailItem(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.mulish(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                height: 1.3,
                color: textPrimary),
          ),
          Text(
            value,
            style: GoogleFonts.mulish(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                height: 1.3,
                color: Color(0xff4f4f4f)),
          ),
        ],
      ),
    );
  }

  Widget detailsRow(String title, String? desc, String val) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
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
                "RS. ",
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
