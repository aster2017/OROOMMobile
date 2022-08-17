import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/core/constants/colors.dart';
import 'package:orb/src/features/hotelDetail/views/hotel_detail.dart';
import 'package:orb/src/features/hotelDetail/widgets/swiper.dart';

class RoomCard extends StatefulWidget {
  const RoomCard({Key? key}) : super(key: key);

  @override
  State<RoomCard> createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  bool favourite = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(HotelDetail());
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.w),
        child: Container(
          margin: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color(0xff00A5F4).withOpacity(.25), blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(10.w),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.w)),
                child: SizedBox(
                  height: 160.h,
                  child: SwiperWidget(
                    images: const [
                      "assets/images/room1.jpg",
                      "assets/images/room2.jpg",
                      "assets/images/room3.jpg"
                    ],
                    bottom: 2.h,
                    height: 160.h,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(6.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Heritage Deluxe Room",
                          style: GoogleFonts.mulish(
                            color: textPrimary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Room Availability -> ",
                              style: GoogleFonts.mulish(
                                color: textPrimary,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                height: 1.2,
                              ),
                            ),
                            Text(
                              "10",
                              style: GoogleFonts.mulish(
                                color: primaryColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Wrap(
                      children: [
                        ...[1, 2, 3, 4].map((e) => Container(
                              width: 170.w,
                              margin: EdgeInsets.symmetric(vertical: 6.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FlutterRemix.hotel_bed_line,
                                    size: 14.w,
                                    color: textPrimary,
                                  ),
                                  Text(
                                    "1 king bed  / 2 Twin Beds",
                                    style: GoogleFonts.mulish(
                                        fontSize: 12.sp,
                                        color: Color(0xff4f4f4f),
                                        fontWeight: FontWeight.w400,
                                        height: 1.25),
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              Container(
                decoration: BoxDecoration(
                  color: checkboxColor,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10.w)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                child: Row(
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
                          text: " per day\n",
                          style: GoogleFonts.mulish(
                              fontSize: 12.sp,
                              color: textPrimary,
                              fontWeight: FontWeight.w600,
                              height: 1.25),
                        ),
                        TextSpan(
                          text: "Includes taxes and fees",
                          style: GoogleFonts.mulish(
                              fontSize: 10.sp,
                              color: Color(0xff4f4f4f),
                              fontWeight: FontWeight.w400,
                              height: 1.25),
                        )
                      ]),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        height: 24.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.w),
                            color: secondaryColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Select Room",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
