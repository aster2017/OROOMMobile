import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/core/constants/colors.dart';
import 'package:orb/src/features/home/models/hotel_search.dart';
import 'package:orb/src/features/hotelDetail/views/hotel_detail.dart';

class ExploreCard extends StatefulWidget {
  const ExploreCard({Key? key, this.hotelSearch}) : super(key: key);
  final HotelSearch? hotelSearch;
  @override
  State<ExploreCard> createState() => _ExploreCardState();
}

class _ExploreCardState extends State<ExploreCard> {
  bool favourite = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.hotelSearch != null) {
          Get.to(HotelDetail(
            hotelUri: widget.hotelSearch!.hotelUri ?? "",
          ));
        }
      },
      child: Container(
        // width: 175.w,
        margin: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Color(0xff00A5F4).withOpacity(.25), blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(10.w),
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 18.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.w),
              child: SizedBox(
                width: 140.w,
                height: 110.h,
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/hotel.jpg",
                      fit: BoxFit.cover,
                      width: 140.w,
                      height: 110.h,
                      color: Colors.black12,
                      colorBlendMode: BlendMode.darken,
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
            ),
            SizedBox(
              width: 6.h,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 110.h,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Row(
                          //   children: [
                          //     Icon(
                          //       FlutterRemix.map_pin_2_fill,
                          //       color: secondaryColor,
                          //       size: 12.w,
                          //     ),
                          //     SizedBox(
                          //       width: 6.w,
                          //     ),
                          //     Text(
                          //      widget.hotelSearch.l "Kathmandu",
                          //       style: GoogleFonts.mulish(
                          //         color: Color(0xff828282),
                          //         fontSize: 12.sp,
                          //         height: 1.2,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            widget.hotelSearch?.hotelName ??
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
                                    color: e == 5
                                        ? Color(0xffbdbdbd)
                                        : Color(0xfff2c94c),
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
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "NPR ",
                                      style: GoogleFonts.mulish(
                                          fontSize: 12.sp,
                                          color: textPrimary,
                                          fontWeight: FontWeight.w600,
                                          height: 1.25),
                                    ),
                                    TextSpan(
                                      text: widget.hotelSearch?.minPrice
                                              .toString() ??
                                          "1,500",
                                      style: GoogleFonts.mulish(
                                          fontSize: 12.sp,
                                          color: redColor,
                                          fontWeight: FontWeight.w700,
                                          height: 1.25),
                                    ),
                                    TextSpan(
                                      text: "/ day",
                                      style: GoogleFonts.mulish(
                                          fontSize: 10.sp,
                                          color: Color(0xffBDBDBD),
                                          fontWeight: FontWeight.w400,
                                          height: 1),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 110.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            // height: 20.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.w),
                                color: secondaryColor),
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
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            // height: 20.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.w),
                                color: primaryColor),
                            child: Icon(
                              FlutterRemix.arrow_right_line,
                              size: 20.sp,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
