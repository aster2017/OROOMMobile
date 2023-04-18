import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/colors.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard(
      {Key? key,
      required this.name,
      required this.rating,
      required this.date,
      required this.description})
      : super(key: key);
  final String name, date, description;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.w), color: Color(0xffF2f2f2)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            FlutterRemix.account_circle_fill,
            color: primaryColor,
            size: 36.sp,
          ),
          SizedBox(
            width: 6.w,
          ),
          SizedBox(
            width: 310.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.mulish(
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          height: 1.25),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    SizedBox(
                      width: 70.w,
                      child: Text(
                        date,
                        style: GoogleFonts.mulish(
                            fontSize: 12.sp,
                            color: Color(0xff4f4f4f),
                            fontWeight: FontWeight.w400,
                            height: 1.25),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6.h,
                ),
                RatingBar.builder(
                  ignoreGestures: false,
                  itemSize: 20.sp,
                  initialRating: rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  unratedColor: Color(0xffbdbdbd),
                  itemCount: 5,
                  itemPadding: EdgeInsets.only(right: 1),
                  itemBuilder: (context, _) => Icon(
                    FlutterRemix.star_fill,
                    color: Color(0xfff2c94c),
                  ),
                  onRatingUpdate: (val) {},
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  description,
                  overflow: TextOverflow.visible,
                  style: GoogleFonts.mulish(
                      fontSize: 12.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      height: 1.25),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
