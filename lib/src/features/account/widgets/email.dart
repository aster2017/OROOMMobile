import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/colors.dart';

class EmailCard extends StatelessWidget {
  const EmailCard({Key? key, required this.date, required this.title})
      : super(key: key);
  final String date, title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      margin: EdgeInsets.only(top: 12.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.w), color: Color(0xffF2f2f2)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            date,
            style: GoogleFonts.mulish(
                fontSize: 14.sp,
                color: Color(0xff4f4f4f),
                fontWeight: FontWeight.w500,
                height: 1.25),
          ),
          SizedBox(
            width: 6.w,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mulish(
                      fontSize: 16.sp,
                      color: textPrimary,
                      fontWeight: FontWeight.w500,
                      height: 1.25),
                ),
                SizedBox(
                  height: 12.h,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.w),
                  child: Image.asset(
                    "assets/images/offer.jpg",
                    fit: BoxFit.cover,
                    width: 260.w,
                    height: 110.h,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
