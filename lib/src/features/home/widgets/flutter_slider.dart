import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orb/src/core/constants/colors.dart';

FlutterSliderTrackBar sliderTrackbar = FlutterSliderTrackBar(
  // inactiveDisabledTrackBarColor: Colors.transparent,
  activeTrackBarHeight: 10.h,
  inactiveTrackBarHeight: 12.h,
  inactiveTrackBar: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
            color: Color(0xff1A6992).withOpacity(0.1),
            offset: Offset(0, 2),
            blurRadius: 4),
        BoxShadow(color: Color(0xff1A6992).withOpacity(0.01)),
        BoxShadow(
          color: Colors.white,
          spreadRadius: -4.0,
          blurRadius: 2.0,
        ),
      ],
      color: Colors.transparent,
      border: Border.all(width: 2, color: Color(0xffF9F9F9))),

  activeTrackBar: BoxDecoration(
    color: secondaryColor,
    borderRadius: BorderRadius.circular(10),
  ),
);

Container sliderHandler = Container(
  width: 26.w,
  height: 26.w,
  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
  child: Center(
    child: Container(
      width: 24.w,
      height: 24.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
            colors: const [Color(0xffF5F3F3), Color(0xffDCDCDC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Center(
        child: Container(
          width: 18.w,
          height: 18.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                colors: const [Color(0xffCECECE), Color(0xffffffff)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          ),
          child: Center(
              child: Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: secondaryColor))),
        ),
      ),
    ),
  ),
);
