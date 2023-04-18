import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/features/app/controller/bottom_nav.dart';

import '../../../core/constants/colors.dart';

class WishlistPage extends StatelessWidget {
  WishlistPage({Key? key}) : super(key: key);
  final BottomNavController bottomNavController =
      Get.find<BottomNavController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: textPrimary),
          title: Text(
            "My Wishlist",
            style: GoogleFonts.mulish(
                color: textPrimary, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Column(children: [
          Divider(
            height: 2,
            color: Color(0xfff2f2f2),
          ),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Expanded(
                    child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: SizedBox(
                      width: 260.w,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/gifs/favourite.gif"),
                            Text(
                              "Keep what you like at hand",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.mulish(
                                  color: textPrimary,
                                  fontSize: 20.sp,
                                  height: 1.25,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Text(
                              "Save all the hotels that you like from your search right here",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.mulish(
                                  color: Color(0xff333333),
                                  fontSize: 14.sp,
                                  height: 1.25,
                                  fontWeight: FontWeight.w500),
                            ),
                          ]),
                    ),
                  ),
                )),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      // Get.offAll(SignupPage());
                      bottomNavController.currentIndex.value = 1;
                    },
                    child: Container(
                      width: 170.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.w),
                          color: primaryColor),
                      child: Center(
                        child: Text(
                          "Start Searching",
                          style: GoogleFonts.mulish(
                              color: whiteColor, height: 1.4, fontSize: 16.sp),
                        ),
                      ),
                    ),
                  ),
                )
              ]))
        ]));
  }
}
