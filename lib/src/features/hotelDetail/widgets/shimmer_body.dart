import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constants/colors.dart';

Widget displayShimmerBody = Shimmer.fromColors(
  baseColor: Colors.grey.shade300,
  highlightColor: Colors.grey.shade100,
  enabled: true,
  child: Stack(
    children: [
      Column(
        children: [
          Container(
            height: 320.h,
            color: Colors.black,
          ),
          Container(
            width: 428.w,
            height: 600.h,
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(50.w))),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120.w,
                    height: 12.sp,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    width: 250.h,
                    height: 16.sp,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Row(
                    children: [
                      ...[1, 2, 3, 4, 5].map(
                        (e) => Container(
                          width: 14.sp,
                          height: 14.sp,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    width: 120.w,
                    height: 14.sp,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  SizedBox(
                      height: 32.h,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Container(
                                width: 26.sp,
                                height: 26.sp,
                                color: Colors.black,
                              ),
                          separatorBuilder: (context, index) => SizedBox(
                                width: 12.w,
                              ),
                          itemCount: 5)),
                  SizedBox(
                    height: 14.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Booking Dates And Details",
                        style: GoogleFonts.mulish(
                            fontSize: 14.sp,
                            color: textPrimary,
                            fontWeight: FontWeight.w500,
                            height: 1.25),
                      ),
                      Text(
                        "Change",
                        style: GoogleFonts.mulish(
                            fontSize: 12.sp,
                            color: redColor,
                            fontWeight: FontWeight.w600,
                            height: 1.25),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 160.w,
                        height: 35.h,
                        color: Colors.black,
                      ),
                      Container(
                        width: 160.w,
                        height: 35.h,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Container(
                    width: 375.w,
                    height: 35.h,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Container(
                    width: 375.w,
                    height: 35.h,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Container(
                    width: 375.w,
                    height: 35.h,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Container(
                    width: 375.w,
                    height: 35.h,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      Positioned(
          bottom: 0,
          child: Container(
            width: 390.w,
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            padding: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
                border: Border.symmetric(
                    horizontal: BorderSide(color: Color(0xffF2F2F2)))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 200.w,
                  height: 35.h,
                  color: Colors.black,
                ),
                Container(
                  width: 120.w,
                  height: 35.h,
                  color: Colors.black,
                ),
              ],
            ),
          ))
    ],
  ),
);
