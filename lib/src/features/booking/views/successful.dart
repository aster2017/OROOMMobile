import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/features/app/controller/bottom_nav.dart';
import 'package:orb/src/features/app/views/app.dart';

import '../../../core/constants/colors.dart';

class SuccessfulPage extends StatelessWidget {
  SuccessfulPage({Key? key}) : super(key: key);
  final BottomNavController bottomNavController =
      Get.find<BottomNavController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.offAll(AppPage());
            },
            icon: Icon(Platform.isAndroid
                ? Icons.arrow_back_rounded
                : Icons.arrow_back_ios_new_rounded),
          ),
          iconTheme: IconThemeData(color: textPrimary),
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
                            Image.asset("assets/gifs/success.gif"),
                            Text(
                              "Successfully Booked!!",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.mulish(
                                  color: textPrimary,
                                  fontSize: 20.sp,
                                  height: 1.25,
                                  fontWeight: FontWeight.w600),
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
                      Get.offAll(AppPage());
                    },
                    child: Container(
                      width: 170.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.w),
                          color: primaryColor),
                      child: Center(
                        child: Text(
                          "Continue Searching",
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
