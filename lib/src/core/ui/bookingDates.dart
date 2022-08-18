import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class BookingDatesRow extends StatelessWidget {
  const BookingDatesRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bookingDatesRow();
  }

  Widget bookingDatesRow() {
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
            bookingDate("2022-02-22")
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
            bookingDate("2022-02-24")
          ]),
        ),
      ],
    );
  }

  Widget bookingDate(String date) {
    return Container(
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
            date,
            style: GoogleFonts.mulish(
                fontSize: 14.sp, height: 1.2, color: Color(0xff828282)),
          )
        ],
      ),
    );
  }
}
