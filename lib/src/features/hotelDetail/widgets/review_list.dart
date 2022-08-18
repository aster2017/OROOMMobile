import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/features/hotelDetail/views/review_all.dart';
import 'package:orb/src/features/hotelDetail/widgets/review_card.dart';

import '../../../core/constants/colors.dart';

class ReviewList extends StatefulWidget {
  const ReviewList({Key? key}) : super(key: key);

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  bool showAll = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.symmetric(
              horizontal: BorderSide(color: Color(0xffF2F2F2)))),
      padding: EdgeInsets.symmetric(vertical: 16.h),
      margin: EdgeInsets.symmetric(vertical: 6.h),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                showAll = !showAll;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Latest Review",
                  style: GoogleFonts.mulish(
                      fontSize: 14.sp,
                      color: textPrimary,
                      fontWeight: FontWeight.w500,
                      height: 1.25),
                ),
                Icon(showAll
                    ? FlutterRemix.arrow_drop_down_line
                    : FlutterRemix.arrow_drop_right_line)
              ],
            ),
          ),
          showAll
              ? Column(
                  children: [
                    MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.separated(
                            padding: EdgeInsets.only(top: 8.h),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => ReviewCard(
                                image: "assets/images/user.png",
                                name: "Amrit Acharya",
                                rating: 4,
                                date: "15 Apr, 2022",
                                description:
                                    '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Velit facilisis venenatis amet potenti sed fringilla. Urna mauris vitae, tristique pulvinar convallis arcu et tincidunt. Cursus et id nulla non tellus, id augue. Laoreet bibendum rhoncus mi cras eu sit. Sapien.'''),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 15.h,
                                ),
                            itemCount: 4)),
                    GestureDetector(
                      onTap: () {
                        Get.to(ReviewAllPage());
                      },
                      child: Container(
                        width: 110.w,
                        height: 34.h,
                        margin: EdgeInsets.only(top: 8.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.w),
                            color: primaryColor),
                        child: Center(
                          child: Text(
                            "See All",
                            style: GoogleFonts.mulish(
                                color: whiteColor,
                                height: 1.4,
                                fontSize: 16.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
