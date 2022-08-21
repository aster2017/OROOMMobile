import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/core/ui/bookingDates.dart';
import 'package:orb/src/core/ui/textfield.dart';
import 'package:orb/src/features/home/controller/search_controller.dart';
import 'package:orb/src/features/search/views/search_page.dart';

import '../../../core/constants/colors.dart';
import '../../../core/functions/number_format.dart';
import '../../../core/ui/bookingDetails.dart';
import '../widgets/flutter_slider.dart';

class SearchFilter extends StatelessWidget {
  final searchController = Get.find<SearchController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        constraints: BoxConstraints(maxHeight: 780.h),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Color(0xff00A5F4).withOpacity(.25), blurRadius: 10)
          ],
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(50.w)),
        ),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        FlutterRemix.close_circle_line,
                        size: 20.sp,
                        color: Color(0xff4f4f4f),
                      )),
                ),
                KTextFormField(
                  label: "Going To",
                  isFilled: true,
                  keyboardType: TextInputType.none,
                  hint: "Where are you going?",
                  onTap: () {
                    showSearch(context: context, delegate: SearchHotel());
                  },
                  prefix: FlutterRemix.map_pin_2_fill,
                ),
                SizedBox(
                  height: 12.h,
                ),
                BookingDatesRow(),
                SizedBox(
                  height: 12.h,
                ),
                SizedBox(
                  height: 12.h,
                ),
                BookingDetailsRow(),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  children: [
                    Text(
                      "Budget per day / per room",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.mulish(
                          color: textPrimary,
                          height: 1.4,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "Rs. ${formatAmount(searchController.roomLowerVal.value.toInt())} - ${formatAmount(searchController.roomUpperVal.value.toInt())}",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.mulish(
                          color: Color(0xff828282),
                          height: 1.4,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6.h,
                ),
                FlutterSlider(
                  values: [
                    searchController.roomLowerVal.value,
                    searchController.roomUpperVal.value,
                  ],
                  tooltip: FlutterSliderTooltip(
                      format: (val) => formatAmount(double.parse(val).toInt())),
                  max: 100000,
                  min: 0,
                  maximumDistance: 100000,
                  rangeSlider: true,
                  trackBar: sliderTrackbar,
                  handlerWidth: 26.w,
                  handlerHeight: 26.w,
                  handler: FlutterSliderHandler(
                    child: sliderHandler,
                  ),
                  rightHandler: FlutterSliderHandler(
                    child: sliderHandler,
                  ),
                  handlerAnimation: FlutterSliderHandlerAnimation(
                      curve: Curves.elasticOut,
                      reverseCurve: null,
                      duration: Duration(milliseconds: 700),
                      scale: 1.4),
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    searchController.roomLowerVal.value = lowerValue;
                    searchController.roomUpperVal.value = upperValue;
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Get.offAll(LoginPage());
                      },
                      child: Container(
                        width: 150.w,
                        height: 44.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.w),
                            border: Border.all(color: primaryColor),
                            color: primaryColor.withOpacity(.05)),
                        child: Center(
                          child: Text(
                            "Clear All",
                            style: GoogleFonts.mulish(
                                color: primaryColor,
                                height: 1.4,
                                fontSize: 16.sp),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Get.offAll(SignupPage());
                      },
                      child: Container(
                        width: 150.w,
                        height: 44.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.w),
                            color: primaryColor),
                        child: Center(
                          child: Text(
                            "Search",
                            style: GoogleFonts.mulish(
                                color: whiteColor,
                                height: 1.4,
                                fontSize: 16.sp),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ]),
        ),
      );
    });
  }
}
