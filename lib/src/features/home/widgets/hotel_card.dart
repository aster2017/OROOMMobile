import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/core/constants/colors.dart';
import 'package:orb/src/features/hotelDetail/views/hotel_detail.dart';

import '../models/hotel.dart';

class HotelCard extends StatefulWidget {
  HotelCard({Key? key, required this.hotel}) : super(key: key);
  final Hotel hotel;
  @override
  State<HotelCard> createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> {
  bool favourite = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(HotelDetail(hotelUri: widget.hotel.uri!));
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
            SizedBox(
              height: 100.h,
              width: 165.w,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.w),
                    child: widget.hotel.imageUrl == null
                        ? Image.asset(
                            "assets/images/hotel.jpg",
                            fit: BoxFit.cover,
                            width: 165.w,
                            height: 100.h,
                            color: Colors.black12,
                            colorBlendMode: BlendMode.darken,
                          )
                        : CachedNetworkImage(
                            imageUrl:
                                "https://astercliqdevstorage.blob.core.windows.net${widget.hotel.imageUrl}",
                            fit: BoxFit.cover,
                            width: 165.w,
                            height: 100.h,
                            color: Colors.black12,
                            colorBlendMode: BlendMode.darken,
                          ),
                  ),
                  Positioned(
                    top: 5.h,
                    right: 5.h,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          favourite = !favourite;
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffF7F8FA).withOpacity(.5),
                            borderRadius: BorderRadius.circular(4.w),
                          ),
                          padding: EdgeInsets.all(4.w),
                          child: Icon(
                            FlutterRemix.heart_fill,
                            size: 18.sp,
                            color: favourite ? redColor : Colors.white,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4.h,
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
                      "${widget.hotel.location}",
                      style: GoogleFonts.mulish(
                        color: Color(0xff828282),
                        fontSize: 12.sp,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xff000000).withOpacity(.05),
                          blurRadius: 4,
                          offset: Offset(4, 4))
                    ],
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                  padding: EdgeInsets.all(4.w),
                  child: Text(
                    "7.5",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.mulish(
                      fontSize: 12.sp,
                      color: whiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              widget.hotel.hotelName ?? "",
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
                        text: "${widget.hotel.startPrice}",
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
