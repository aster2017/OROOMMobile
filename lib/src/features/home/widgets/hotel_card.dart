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
            BoxShadow(color: Color(0xff000000).withOpacity(.15), blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100.h,
              width: 175.w,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10.w)),
                    child: widget.hotel.imageUrl == null
                        ? Image.asset(
                            "assets/images/hotel.jpg",
                            fit: BoxFit.cover,
                            width: 175.w,
                            height: 100.h,
                            color: Colors.black12,
                            colorBlendMode: BlendMode.darken,
                          )
                        : CachedNetworkImage(
                            imageUrl:
                                "https://astercliqdevstorage.blob.core.windows.net${widget.hotel.imageUrl}",
                            fit: BoxFit.cover,
                            width: 175.w,
                            height: 100.h,
                            color: Colors.black12,
                            colorBlendMode: BlendMode.darken,
                          ),
                  ),
                  // Positioned(
                  //   top: 5.h,
                  //   right: 5.h,
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       setState(() {
                  //         favourite = !favourite;
                  //       });
                  //     },
                  //     child: Container(
                  //         decoration: BoxDecoration(
                  //           color: Color(0xffF7F8FA).withOpacity(.5),
                  //           borderRadius: BorderRadius.circular(4.w),
                  //         ),
                  //         padding: EdgeInsets.all(4.w),
                  //         child: Icon(
                  //           FlutterRemix.heart_fill,
                  //           size: 18.sp,
                  //           color: favourite ? redColor : Colors.white,
                  //         )),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Container(
              padding: EdgeInsets.all(5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              FlutterRemix.map_pin_2_fill,
                              color: secondaryColor,
                              size: 12.w,
                            ),
                            SizedBox(
                              width: 6.w,
                            ),
                            Expanded(
                              child: Text(
                                "${widget.hotel.location}",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.mulish(
                                  color: Color(0xff828282),
                                  fontSize: 12.sp,
                                  height: 1.2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            FlutterRemix.star_fill,
                            size: 12.sp,
                            color: Color(0xfff2c94c),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "4.5",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.mulish(
                              fontSize: 12.sp,
                              color: textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
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
                        fontSize: 16.sp,
                        color: textPrimary,
                        fontWeight: FontWeight.w700,
                        height: 1.25),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  RichText(
                      textAlign: TextAlign.right,
                      text: TextSpan(children: [
                        TextSpan(
                          text: "RS. ",
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
                          text: "/ per day",
                          style: GoogleFonts.mulish(
                              fontSize: 10.sp,
                              color: Color(0xffBDBDBD),
                              fontWeight: FontWeight.w400,
                              height: 1),
                        )
                      ])),
                  SizedBox(
                    height: 6.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        height: 24.h,
                        constraints: BoxConstraints(maxWidth: 80.sp),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.w),
                            color: primaryColor),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Book now",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.mulish(
                                  color: whiteColor,
                                  height: 1,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
