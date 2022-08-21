import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/core/constants/colors.dart';
import 'package:orb/src/core/ui/footer.dart';
import 'package:orb/src/features/app/views/app.dart';
import 'package:orb/src/features/home/views/home.dart';
import 'package:orb/src/features/login/views/login.dart';
import 'package:orb/src/features/signup/views/signup.dart';
import 'package:url_launcher/url_launcher.dart';

import 'onBoardPage.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with TickerProviderStateMixin {
  PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  double height = 0;
  List<Widget> onBoardingScreens = [
    OnBoardPage(
        image: "onBoard1",
        title: "Find the best hotels for your vacation.",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Turpis id commodo, neque libero gravida ornare ac eget volutpat."),
    OnBoardPage(
        image: "onBoard2",
        title: "Book hotel rooms with just a few clicks.",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Turpis id commodo, neque libero gravida ornare ac eget volutpat."),
    OnBoardPage(
        image: "onBoard3",
        title: "Book hotel rooms with just a few clicks.",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Turpis id commodo, neque libero gravida ornare ac eget volutpat."),
  ];
  @override
  void initState() {
    // changeStatus();
    super.initState();
  }

  // Future<void> changeStatus() async {
  //   GetStorage box = GetStorage();
  //   box.write('seen', true);
  // }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 10,
          automaticallyImplyLeading: false,
          actions: [
            (currentIndex == onBoardingScreens.length - 1)
                ? GestureDetector(
                    onTap: () {
                      Get.offAll(AppPage());
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 20.w),
                      child: Row(
                        children: [
                          Text(
                            "Proceed without Sing In / Sign Up",
                            style: GoogleFonts.mulish(color: textPrimary),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: textPrimary,
                            size: 12.w,
                          ),
                        ],
                      ),
                    ),
                  )
                : Container()
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              height: 580.h,
              child: PageView(
                controller: pageController,
                physics: BouncingScrollPhysics(),
                onPageChanged: (value) => setState(() {
                  currentIndex = value;
                }),
                children: onBoardingScreens,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 6.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return index == currentIndex
                          ? Container(
                              width: 24.w,
                              height: 6.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: primaryColor),
                            )
                          : Container(
                              width: 6.w,
                              height: 6.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primaryColor.withOpacity(.6)),
                            );
                    },
                    itemCount: onBoardingScreens.length,
                    separatorBuilder: (context, index) => SizedBox(
                      width: 4.w,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 20.w, top: 40.h, right: 20.w),
              child: currentIndex == 2
                  ? Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.offAll(LoginPage());
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
                                "Sign In",
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
                            Get.offAll(SignupPage());
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
                        )
                      ],
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.linear);
                            setState(() {
                              currentIndex = currentIndex++;
                            });
                          },
                          child: Container(
                            width: 150.w,
                            height: 44.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                color: primaryColor),
                            child: Center(
                              child: Text(
                                "Next",
                                style: GoogleFonts.mulish(
                                    color: whiteColor,
                                    height: 1.4,
                                    fontSize: 16.sp),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
            ),
            Expanded(child: Container()),
            FooterWidget()
          ],
        )

        // bottomNavigationBar: buildFooter(),
        );
  }
}
