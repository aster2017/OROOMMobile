import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/features/app/controller/bottom_nav.dart';
import 'package:orb/src/features/login/views/login.dart';

import '../../../core/constants/colors.dart';

class LogOutSheet extends StatelessWidget {
  BottomNavController bottomNavController = Get.find<BottomNavController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 300.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Color(0xff00A5F4).withOpacity(.25), blurRadius: 10)
        ],
        borderRadius: BorderRadius.vertical(top: Radius.circular(50.w)),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Log Out",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mulish(
                      color: redColor,
                      fontSize: 16.sp,
                      height: 1.25,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Divider(
                  height: 2,
                  color: Color(0xfff2f2f2),
                ),
              ],
            ),
            SizedBox(
              width: 260.w,
              child: Text(
                "Are you sure you want to Logout?",
                textAlign: TextAlign.center,
                style: GoogleFonts.mulish(
                    color: textPrimary,
                    fontSize: 20.sp,
                    height: 1.25,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // Get.offAll(LoginPage());
                    Get.back();
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
                        "Cancel",
                        style: GoogleFonts.mulish(
                            color: primaryColor, height: 1.4, fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    bottomNavController.currentIndex.value = 0;
                    Get.offAll(LoginPage());
                  },
                  child: Container(
                    width: 150.w,
                    height: 44.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.w),
                        color: primaryColor),
                    child: Center(
                      child: Text(
                        "Yes, Continue",
                        style: GoogleFonts.mulish(
                            color: whiteColor, height: 1.4, fontSize: 16.sp),
                      ),
                    ),
                  ),
                )
              ],
            )
          ]),
    );
  }
}
