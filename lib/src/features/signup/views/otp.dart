import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/core/ui/footer.dart';
import 'package:orb/src/features/login/views/login.dart';
import 'package:orb/src/features/signup/views/singup_form.dart';

import '../../../core/constants/colors.dart';
import '../../home/views/home.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  bool resend = false;
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  FocusNode? pin5FocusNode;
  FocusNode? pin6FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    pin5FocusNode!.dispose();
    pin6FocusNode!.dispose();
  }

  TextEditingController pin1Controller = TextEditingController();
  TextEditingController pin2Controller = TextEditingController();
  TextEditingController pin3Controller = TextEditingController();
  TextEditingController pin4Controller = TextEditingController();
  TextEditingController pin5Controller = TextEditingController();
  TextEditingController pin6Controller = TextEditingController();

  void nextField(
      String value, FocusNode? focusNode, TextEditingController controller) {
    setState(() {
      errorMessage = "";
    });
    if (value.length == 1) {
      controller.clear();
      focusNode!.requestFocus();
    }
  }

  void previousField(String value, FocusNode? focusNode,
      TextEditingController editingController) {
    editingController.clear();
    focusNode!.requestFocus();
  }

  double screenWidth = 0;
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      backgroundColor: primaryColor,
      body: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Center(
            child: Text(
              "LOGO HERE",
              style: GoogleFonts.mulish(
                  color: whiteColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 24.sp),
            ),
          ),
          SizedBox(
            height: 80.h,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(50.h))),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(bottom: 0, child: FooterWidget()),
                  Padding(
                    padding: EdgeInsets.only(bottom: 25.h, top: 20.h),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Center(
                          child: Text(
                            "Verification",
                            style: GoogleFonts.mulish(
                                color: textPrimary,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp,
                                height: 1.2),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            children: [
                              Text(
                                'A 4 digit OTP code was sent to your phone number  (+977)-98******84. Please enter it below.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.workSans(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    color: textPrimary,
                                    height: 1.2),
                              ),
                              SizedBox(
                                height: 40.h,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 50.w),
                                child: _otpField(),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(HomePage());
                                },
                                child: Container(
                                  width: 150.w,
                                  height: 44.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.w),
                                      color: primaryColor),
                                  child: Center(
                                    child: Text(
                                      "Confirm",
                                      style: GoogleFonts.mulish(
                                          color: whiteColor,
                                          height: 1.4,
                                          fontSize: 16.sp),
                                    ),
                                  ),
                                ),
                              ),
                              buildTimer(),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration otpInputDecoration() {
    return InputDecoration(
      counterText: "",
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.h),
          borderSide: BorderSide(color: textPrimary)),
      contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 4.w),
    );
  }

  Widget _otpField() {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 40.w,
            width: 40.w,
            child: TextFormField(
              controller: pin1Controller,
              autofocus: true,
              maxLength: 1,
              style: GoogleFonts.workSans(
                  color: textPrimary, fontSize: 17.sp, height: 1.2),
              keyboardType: TextInputType.number,
              cursorColor: textPrimary,
              textAlign: TextAlign.center,
              decoration: otpInputDecoration(),
              onChanged: (value) {
                nextField(value, pin2FocusNode, pin2Controller);
              },
            ),
          ),
          SizedBox(
            height: 40.w,
            width: 40.w,
            child: TextFormField(
              maxLength: 1,
              focusNode: pin2FocusNode,
              controller: pin2Controller,
              style: GoogleFonts.workSans(
                  color: textPrimary, fontSize: 17.sp, height: 1.2),
              keyboardType: TextInputType.number,
              cursorColor: textPrimary,
              textAlign: TextAlign.center,
              decoration: otpInputDecoration(),
              onChanged: (value) =>
                  nextField(value, pin3FocusNode, pin3Controller),
            ),
          ),
          SizedBox(
            height: 40.w,
            width: 40.w,
            child: TextFormField(
              maxLength: 1,
              controller: pin3Controller,
              focusNode: pin3FocusNode,
              style: GoogleFonts.workSans(
                  color: textPrimary, fontSize: 17.sp, height: 1.2),
              keyboardType: TextInputType.number,
              cursorColor: textPrimary,
              textAlign: TextAlign.center,
              decoration: otpInputDecoration(),
              onChanged: (value) =>
                  nextField(value, pin4FocusNode, pin4Controller),
            ),
          ),
          SizedBox(
            height: 40.w,
            width: 40.w,
            child: TextFormField(
              maxLength: 1,
              controller: pin4Controller,
              focusNode: pin4FocusNode,
              style: GoogleFonts.workSans(
                  color: textPrimary, fontSize: 17.sp, height: 1.2),
              keyboardType: TextInputType.number,
              cursorColor: textPrimary,
              textAlign: TextAlign.center,
              decoration: otpInputDecoration(),
              onChanged: (value) {
                pin4FocusNode!.unfocus();
                setState(() {
                  errorMessage = "";
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildTimer() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          resend
              ? Icon(
                  FlutterRemix.arrow_go_back_line,
                  color: textPrimary,
                  size: 16.w,
                )
              : Icon(
                  Icons.info_outline,
                  color: textPrimary,
                ),
          SizedBox(
            width: 10.w,
          ),
          TweenAnimationBuilder(
            onEnd: () {
              setState(() {
                resend = true;
              });
            },
            tween: Tween(begin: 60.0, end: 0.0),
            duration: Duration(seconds: 60),
            builder: (_, dynamic value, child) => resend
                ? Text(
                    "Resend code",
                    style: TextStyle(
                        color: textPrimary,
                        fontSize: 14.sp,
                        height: 1,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500),
                  )
                : Flexible(
                    child: RichText(
                      overflow: TextOverflow.visible,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "Waiting for the code? You will be able to request a new one in",
                            style: TextStyle(
                                color: textPrimary,
                                fontSize: 12.sp,
                                height: 1.2,
                                fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                            text: " ${value.toInt()}",
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 14.sp,
                                height: 1.2,
                                fontWeight: FontWeight.w500),
                          ),
                          TextSpan(
                            text: " seconds",
                            style: TextStyle(
                                color: textPrimary,
                                fontSize: 12.sp,
                                height: 1.2,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
