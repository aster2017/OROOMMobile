import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/core/ui/footer.dart';
import 'package:orb/src/features/login/views/login.dart';
import 'package:orb/src/features/signup/views/otp.dart';
import 'package:orb/src/features/signup/views/singup_form.dart';

import '../../../core/constants/colors.dart';
import '../../home/views/home.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isEmail = true;
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController confirmPassCtrl = TextEditingController();
  TextEditingController fullNameCtrl = TextEditingController();
  final GlobalKey<FormState> signupKey = GlobalKey<FormState>();
  String phoneCode = "+977";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              Get.offAll(HomePage());
            },
            child: Container(
              padding: EdgeInsets.only(right: 20.w),
              child: Row(
                children: [
                  Text(
                    "Proceed without Sing In / Sign Up",
                    style: GoogleFonts.mulish(color: whiteColor),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: whiteColor,
                    size: 12.w,
                  ),
                ],
              ),
            ),
          )
        ],
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
                    padding: EdgeInsets.only(bottom: 25.h, top: 10.h),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Center(
                          child: Text(
                            "Sign Up",
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
                        SignUpForm(
                          formKey: signupKey,
                          phoneCtrl: phoneCtrl,
                          phoneCode: phoneCode,
                          passCtrl: passCtrl,
                          onChangedCountry: (val) {
                            setState(() {
                              phoneCode = val!;
                            });
                          },
                          confirmPassCtrl: confirmPassCtrl,
                          emailCtrl: emailCtrl,
                          nameCtrl: fullNameCtrl,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(OtpPage());
                          },
                          child: Container(
                            width: 150.w,
                            height: 44.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                color: primaryColor),
                            child: Center(
                              child: Text(
                                "Sign Up",
                                style: GoogleFonts.mulish(
                                    color: whiteColor,
                                    height: 1.4,
                                    fontSize: 16.sp),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: GoogleFonts.mulish(
                                  fontWeight: FontWeight.w400,
                                  color: textPrimary,
                                  fontSize: 14.sp,
                                  height: 1.2),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.offAll(LoginPage());
                              },
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  alignment: Alignment.center),
                              child: Text(
                                "Sign In",
                                style: GoogleFonts.mulish(
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        RichText(
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                style: GoogleFonts.mulish(
                                    fontSize: 12.sp,
                                    height: 1.2,
                                    color: textPrimary),
                                children: [
                                  TextSpan(
                                      text:
                                          "By signing in or creating an account, you agree with our "),
                                  TextSpan(
                                      text: "Terms & Conditions",
                                      style: GoogleFonts.mulish(
                                          color: primaryColor),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {}),
                                  TextSpan(
                                    text: " and ",
                                  ),
                                  TextSpan(
                                      text: "Privacy Statement",
                                      style: GoogleFonts.mulish(
                                          color: primaryColor),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {})
                                ]))
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

  Container signInTabs() {
    return Container(
      width: 245.w,
      height: 32.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.h),
        border: Border.all(color: Color(0xff4f4f4f)),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
              alignment: isEmail ? Alignment.centerLeft : Alignment.centerRight,
              duration: Duration(milliseconds: 400),
              child: Container(
                width: 120.w,
                decoration: BoxDecoration(
                    color: Color(0xff4f4f4f),
                    borderRadius: BorderRadius.circular(16.w)),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isEmail = true;
                  });
                },
                child: Container(
                  width: 120.w,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16.w)),
                  child: Center(
                    child: Text(
                      "Email",
                      style: GoogleFonts.mulish(
                          color: isEmail ? whiteColor : textPrimary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          height: 1.5),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isEmail = false;
                  });
                },
                child: Container(
                  width: 120.w,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16.w)),
                  child: Center(
                    child: Text(
                      "Mobile",
                      style: GoogleFonts.mulish(
                          color: !isEmail ? whiteColor : textPrimary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          height: 1.5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
