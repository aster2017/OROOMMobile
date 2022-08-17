import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/core/constants/colors.dart';
import 'package:orb/src/features/hotelDetail/views/hotel_detail.dart';

class HotelCard extends StatefulWidget {
  const HotelCard({Key? key}) : super(key: key);

  @override
  State<HotelCard> createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> {
  bool favourite = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(HotelDetail());
      },
      child: Container(
        width: 175.w,
        margin: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Color(0xff00A5F4).withOpacity(.25), blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(10.w),
        ),
        padding: EdgeInsets.all(5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.w),
              child: Image.asset(
                "assets/images/hotel.jpg",
                fit: BoxFit.cover,
                width: 165.w,
                height: 100.h,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      FlutterRemix.map_pin_2_fill,
                      color: secondaryColor,
                      size: 12.w,
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    Text(
                      "Kathmandu",
                      style: GoogleFonts.mulish(
                        color: Color(0xff828282),
                        fontSize: 12.sp,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      favourite = !favourite;
                    });
                  },
                  child: Container(
                      width: 24.w,
                      height: 24.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xff000000).withOpacity(.05),
                              blurRadius: 4,
                              offset: Offset(4, 4))
                        ],
                        borderRadius: BorderRadius.circular(4.w),
                      ),
                      padding: EdgeInsets.all(4.w),
                      child: Icon(
                        FlutterRemix.heart_fill,
                        size: 12.w,
                        color: favourite ? redColor : Color(0xffbdbdbd),
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              "Hotel Mystic Mountain",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.mulish(
                  fontSize: 14.sp,
                  color: textPrimary,
                  fontWeight: FontWeight.w600,
                  height: 1.25),
            ),
            SizedBox(
              height: 6.h,
            ),
            Row(
              children: [
                ...[1, 2, 3, 4, 5].map((e) => Icon(
                      FlutterRemix.star_fill,
                      size: 14.w,
                      color: e == 5 ? Color(0xffbdbdbd) : Color(0xfff2c94c),
                    ))
              ],
            ),
            SizedBox(
              height: 6.h,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    textAlign: TextAlign.right,
                    text: TextSpan(children: [
                      TextSpan(
                        text: "NPR ",
                        style: GoogleFonts.mulish(
                            fontSize: 12.sp,
                            color: textPrimary,
                            fontWeight: FontWeight.w600,
                            height: 1.25),
                      ),
                      TextSpan(
                        text: "1,500",
                        style: GoogleFonts.mulish(
                            fontSize: 12.sp,
                            color: redColor,
                            fontWeight: FontWeight.w700,
                            height: 1.25),
                      ),
                      TextSpan(
                        text: "\n per day",
                        style: GoogleFonts.mulish(
                            fontSize: 10.sp,
                            color: Color(0xffBDBDBD),
                            fontWeight: FontWeight.w400,
                            height: 1),
                      )
                    ])),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    height: 20.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.w),
                        color: primaryColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Book now",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.mulish(
                              color: whiteColor,
                              height: 1,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          FlutterRemix.arrow_drop_right_line,
                          size: 12.w,
                          color: whiteColor,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
