import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:orb/src/features/home/controller/search_controller.dart';

import '../constants/colors.dart';

class BookingDatesRow extends StatelessWidget {
  BookingDatesRow({Key? key, this.changeDate = true}) : super(key: key);
  final bool changeDate;
  SearchController searchController = Get.find<SearchController>();
  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context, {bool isFrom = true}) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: (isFrom
            ? searchController.checkinDate.value
            : searchController.checkOutDate.value),
        fieldHintText: isFrom ? "Check In Date" : "Check Out Date",
        initialDatePickerMode: DatePickerMode.day,
        firstDate: isFrom ? currentDate : searchController.checkinDate.value,
        lastDate: currentDate.add(Duration(days: 365)));

    if (picked != null &&
        picked !=
            (isFrom
                ? searchController.checkinDate.value
                : searchController.checkOutDate.value)) {
      if (isFrom) {
        searchController.checkinDate.value = picked;
      } else {
        searchController.checkOutDate.value = picked;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return bookingDatesRow(context);
  }

  Widget bookingDatesRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Check In",
                style: GoogleFonts.mulish(
                    color: textPrimary,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    height: 1.2),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            bookingDate(context, true)
          ]),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: Column(children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Check In",
                style: GoogleFonts.mulish(
                    color: textPrimary,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    height: 1.2),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            bookingDate(context, false)
          ]),
        ),
      ],
    );
  }

  Widget bookingDate(BuildContext context, bool isFrom) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          if (changeDate) {
            _selectDate(context, isFrom: isFrom);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
          decoration: BoxDecoration(
              color: primaryColor.withOpacity(.1),
              borderRadius: BorderRadius.circular(5.h)),
          child: Row(
            children: [
              Icon(
                FlutterRemix.calendar_line,
                color: Color(0xff828282),
                size: 16.w,
              ),
              SizedBox(
                width: 6.w,
              ),
              Text(
                isFrom
                    ? DateFormat("yyyy-MM-dd")
                        .format(searchController.checkinDate.value)
                    : DateFormat("yyyy-MM-dd")
                        .format(searchController.checkOutDate.value),
                style: GoogleFonts.mulish(
                    fontSize: 14.sp, height: 1.2, color: Color(0xff828282)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
