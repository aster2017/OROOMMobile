import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/core/constants/colors.dart';
import 'package:orb/src/features/hotelDetail/views/hotel_detail.dart';

import '../models/hotel.dart';

class PopularHotelCard extends StatefulWidget {
  PopularHotelCard({Key? key, required this.hotel}) : super(key: key);
  final Hotel hotel;
  @override
  State<PopularHotelCard> createState() => _PopularHotelCardState();
}

class _PopularHotelCardState extends State<PopularHotelCard> {
  bool favourite = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(HotelDetail(hotelUri: widget.hotel.uri!));
      },
      child: Container(
        width: 175.w,
        height: 240.h,
        margin: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Color(0xff000000).withOpacity(.15), blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Stack(
          children: [
            SizedBox(
              height: 240.h,
              width: 175.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.w),
                child: widget.hotel.imageUrl == null
                    ? Image.asset(
                        "assets/images/hotel.jpg",
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        imageUrl:
                            "https://astercliqdevstorage.blob.core.windows.net${widget.hotel.imageUrl}",
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Container(
              width: 175.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  gradient: LinearGradient(colors: [
                    Color(0xff82c141).withOpacity(.1),
                    Color(0xff0A85B4).withOpacity(.8),
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: 165.w,
                margin: EdgeInsets.all(5.w),
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  color: Colors.white.withOpacity(.8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                      height: 10.h,
                    ),
                    Text(
                      widget.hotel.hotelName ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.mulish(
                          fontSize: 14.sp,
                          color: textPrimary,
                          fontWeight: FontWeight.w700,
                          height: 1.25),
                    ),
                    SizedBox(
                      height: 10.h,
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
                                color: textPrimary,
                                fontWeight: FontWeight.w400,
                                height: 1),
                          )
                        ])),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
