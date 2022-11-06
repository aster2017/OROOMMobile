import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/core/authentication_manager.dart';
import 'package:orb/src/core/controller/auth_controller.dart';
import 'package:orb/src/features/account/views/profile_edit.dart';
import 'package:orb/src/features/account/views/settings.dart';
import 'package:orb/src/features/account/views/upcoming_booking.dart';
import 'package:orb/src/features/account/widgets/logout_sheet.dart';
import 'package:orb/src/features/account/widgets/profile_menu.dart';
import 'package:orb/src/features/login/views/login.dart';
import 'package:orb/src/features/signup/views/otp.dart';

import '../../../core/constants/colors.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);
  AuthenticationManager authenticationManager =
      Get.find<AuthenticationManager>();
  AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: textPrimary),
        title: Text(
          "Profile",
          style: GoogleFonts.mulish(
              color: textPrimary, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Obx(() => authenticationManager.isLogged.value == true
          ? loggedInBody()
          : loggedOutBody(context)),
    );
  }

  Widget loggedInBody() {
    return Column(
      children: [
        Divider(
          height: 2,
          color: Color(0xfff2f2f2),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffF2F2F2),
                    ),
                    borderRadius: BorderRadius.circular(6.w)),
                margin: EdgeInsets.symmetric(vertical: 6.h),
                padding: EdgeInsets.all(12.w),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      FlutterRemix.account_circle_fill,
                      color: primaryColor,
                      size: 42.sp,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${authController.user.value?.firstName ?? ""} ${authController.user.value?.lastName ?? ""}",
                          style: GoogleFonts.mulish(
                              fontSize: 18.sp,
                              color: textPrimary,
                              fontWeight: FontWeight.w600,
                              height: 1.25),
                        ),
                        SizedBox(height: 6.h),
                        authController.user.value!.emailConfirmed == true
                            ? Text(
                                authController.user.value?.email ??
                                    "abc@example.com",
                                style: GoogleFonts.mulish(
                                    fontSize: 16.sp,
                                    color: Color(0xff4f4f4f),
                                    fontWeight: FontWeight.w400,
                                    height: 1.25),
                              )
                            : GestureDetector(
                                // style: TextButton.styleFrom(
                                //     padding: EdgeInsets.symmetric(vertical: 0)),
                                onTap: () {
                                  Get.to(OtpPage());
                                },
                                child: Text(
                                  "Verify Email",
                                  style: GoogleFonts.mulish(
                                      fontSize: 16.sp,
                                      color: redColor,
                                      fontWeight: FontWeight.w400,
                                      height: 1.25),
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
              ProfileMenu(
                title: "Edit Personal Information",
                onTap: () {
                  Get.to(EditProfile());
                },
                icon: FlutterRemix.user_3_line,
              ),
              SizedBox(
                height: 6.h,
              ),
              ProfileMenu(
                title: "Notification",
                onTap: () {},
                icon: FlutterRemix.notification_3_line,
              ),
              SizedBox(
                height: 6.h,
              ),
              ProfileMenu(
                title: "Upcoming Booking",
                onTap: () {
                  Get.to(UpcomingBooking());
                },
                icon: FlutterRemix.suitcase_line,
              ),
              SizedBox(
                height: 6.h,
              ),
              ProfileMenu(
                title: "Settings",
                onTap: () {
                  Get.to(SettingsPage());
                },
                icon: FlutterRemix.settings_5_line,
              ),
              SizedBox(
                height: 6.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    LogOutSheet(),
                    barrierColor: primaryColor.withOpacity(.1),
                    isDismissible: false,
                    isScrollControlled: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.w),
                    ),
                    enableDrag: true,
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        FlutterRemix.logout_box_line,
                        color: primaryColor,
                        size: 18.sp,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        "Log Out",
                        style: GoogleFonts.mulish(
                            fontSize: 14.sp,
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                            height: 1.25),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget loggedOutBody(BuildContext context) {
    return Column(
      children: [
        Divider(
          height: 2,
          color: Color(0xfff2f2f2),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffF2F2F2),
                    ),
                    borderRadius: BorderRadius.circular(6.w)),
                margin: EdgeInsets.symmetric(vertical: 6.h),
                padding: EdgeInsets.all(12.w),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      FlutterRemix.account_circle_fill,
                      color: primaryColor,
                      size: 42.sp,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "You are not Logged In",
                          style: GoogleFonts.mulish(
                              fontSize: 18.sp,
                              color: textPrimary,
                              fontWeight: FontWeight.w600,
                              height: 1.25),
                        ),
                        SizedBox(height: 6.h),
                        GestureDetector(
                          // style: TextButton.styleFrom(
                          //     padding: EdgeInsets.symmetric(vertical: 0)),
                          onTap: () {
                            Get.to(LoginPage());
                          },
                          child: Text(
                            "Login",
                            style: GoogleFonts.mulish(
                                fontSize: 16.sp,
                                color: primaryColor,
                                fontWeight: FontWeight.w400,
                                height: 1.25),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ProfileMenu(
                title: "Notification",
                onTap: () {},
                icon: FlutterRemix.notification_3_line,
              ),
              SizedBox(
                height: 6.h,
              ),
              ProfileMenu(
                title: "Settings",
                onTap: () {
                  Get.to(SettingsPage());
                },
                icon: FlutterRemix.settings_5_line,
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
