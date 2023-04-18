import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/features/account/data/model/myBooking.dart';

import '../../../core/constants/colors.dart';

class UpcomingCard extends StatelessWidget {
  const UpcomingCard(
      {Key? key,
      required this.title,
      required this.date,
      required this.type,
      required this.pay,
      required this.bookingModel,
      required this.cancel})
      : super(key: key);
  final String title, date, type;
  final Function pay;
  final Function cancel;
  final MyBookingModel bookingModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.symmetric(
              horizontal: BorderSide(color: Color(0xffF2F2F2)))),
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        children: [
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    date,
                    style: GoogleFonts.mulish(
                        fontSize: 14.sp,
                        color: Color(0xff4f4f4f),
                        fontWeight: FontWeight.w500,
                        height: 1.25),
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  Expanded(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mulish(
                          fontSize: 16.sp,
                          color: textPrimary,
                          fontWeight: FontWeight.w500,
                          height: 1.25),
                    ),
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                type,
                style: GoogleFonts.mulish(
                    fontSize: 14.sp,
                    color: textPrimary,
                    fontWeight: FontWeight.w500,
                    height: 1.25),
              ),
            ]),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (bookingModel.paymentStatusCodeId == 303)
                GestureDetector(
                  onTap: () {
                    pay.call();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    height: 22.h,
                    width: 65.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.w),
                        color: secondaryColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Pay",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.mulish(
                              color: whiteColor,
                              height: 1,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          FlutterRemix.arrow_right_s_line,
                          size: 12.w,
                          color: whiteColor,
                        )
                      ],
                    ),
                  ),
                ),
              SizedBox(
                height: 6.w,
              ),
              GestureDetector(
                onTap: () {
                  cancel.call();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  width: 65.w,
                  height: 22.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.w),
                      color: primaryColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Print",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.mulish(
                            color: whiteColor,
                            height: 1,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        FlutterRemix.arrow_right_s_line,
                        size: 12.w,
                        color: whiteColor,
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
