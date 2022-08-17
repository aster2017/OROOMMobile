import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:orb/src/core/constants/colors.dart';
import 'package:orb/src/features/home/widgets/hotel_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          width: 25.w,
          height: 25.w,
          margin: EdgeInsets.only(left: 20.w),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color(0xff00A5F4).withOpacity(.25), blurRadius: 10)
              ]),
          child: Center(
            child: Icon(
              FlutterRemix.notification_fill,
              color: primaryColor,
              size: 16.w,
            ),
          ),
        ),
        title: Text(
            "${DateFormat.yMMMMd().format(DateTime.now())} | ${DateFormat.jm().format(DateTime.now())} | Kathmandu",
            style: GoogleFonts.mulish(
                color: Color(0xff4f4f4f),
                fontWeight: FontWeight.w500,
                fontSize: 10.sp,
                height: 1.25)),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: Row(children: [
              Icon(
                FlutterRemix.account_circle_fill,
                color: primaryColor,
                size: 16.w,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                "Amrit",
                style: GoogleFonts.mulish(color: textPrimary),
              ),
            ]),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            margin: EdgeInsets.only(top: 20.h),
            child: Text(
              "Going To",
              style: GoogleFonts.mulish(
                  fontSize: 16.sp, fontWeight: FontWeight.w600, height: 1.25),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Container(
              height: 50.w,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xff00A5F4).withOpacity(.25),
                        blurRadius: 10)
                  ],
                  borderRadius: BorderRadius.circular(10.w)),
              child: Row(
                children: [
                  Icon(
                    FlutterRemix.search_line,
                    color: primaryColor,
                    size: 14.w,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    "Where you going ?",
                    style: GoogleFonts.mulish(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: primaryColor.withOpacity(.4),
                        height: 1.25),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Hotels Around",
                            style: GoogleFonts.mulish(
                                fontSize: 16.sp,
                                color: textPrimary,
                                fontWeight: FontWeight.w600,
                                height: 1.25),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.only(right: 20.w),
                              child: Row(
                                children: [
                                  Text(
                                    "View All",
                                    style: GoogleFonts.mulish(
                                      color: Color(0xff828282),
                                      fontSize: 14.sp,
                                      height: 1.2,
                                    ),
                                  ),
                                  Icon(
                                    FlutterRemix.arrow_right_line,
                                    color: Color(0xff828282),
                                    size: 12.w,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                    height: 230.h,
                    margin: EdgeInsets.only(top: 10.h),
                    padding: EdgeInsets.only(left: 10.w),
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => HotelCard(),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 14.w,
                            ),
                        itemCount: 5)),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Special Offers",
                        style: GoogleFonts.mulish(
                            fontSize: 16.sp,
                            color: textPrimary,
                            fontWeight: FontWeight.w600,
                            height: 1.25),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.w),
                        child: Image.asset(
                          "assets/images/offer.jpg",
                          fit: BoxFit.cover,
                          width: 385.w,
                          height: 160.h,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Most Popular",
                            style: GoogleFonts.mulish(
                                fontSize: 16.sp,
                                color: textPrimary,
                                fontWeight: FontWeight.w600,
                                height: 1.25),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.only(right: 20.w),
                              child: Row(
                                children: [
                                  Text(
                                    "View All",
                                    style: GoogleFonts.mulish(
                                      color: Color(0xff828282),
                                      fontSize: 14.sp,
                                      height: 1.2,
                                    ),
                                  ),
                                  Icon(
                                    FlutterRemix.arrow_right_line,
                                    color: Color(0xff828282),
                                    size: 12.w,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                    height: 230.h,
                    margin: EdgeInsets.only(top: 10.h),
                    padding: EdgeInsets.only(left: 10.w),
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => HotelCard(),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 14.w,
                            ),
                        itemCount: 5)),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
