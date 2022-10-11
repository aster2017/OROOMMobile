import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:orb/src/core/authentication_manager.dart';
import 'package:orb/src/core/constants/colors.dart';
import 'package:orb/src/core/controller/auth_controller.dart';
import 'package:orb/src/features/app/controller/bottom_nav.dart';
import 'package:orb/src/features/booking/controller/bookingController.dart';
import 'package:orb/src/features/home/controller/hotel_controller.dart';
import 'package:orb/src/features/home/controller/search_controller.dart';
import 'package:orb/src/features/home/views/search_filter.dart';
import 'package:orb/src/features/home/widgets/hotel_card.dart';
import 'package:orb/src/features/login/views/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SearchController searchController = Get.put(SearchController());
  final AuthController authController = Get.put(AuthController());
  final BookingController bookingController = Get.put(BookingController());
  final BottomNavController bottomNavController =
      Get.find<BottomNavController>();
  final AuthenticationManager authenticationManager =
      Get.find<AuthenticationManager>();
  final HotelController hotelController = Get.find<HotelController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          width: 25.w,
          height: 25.w,
          margin: EdgeInsets.only(left: 20.w),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color(0xff00A5F4).withOpacity(.25), blurRadius: 10)
              ]),
          child: Center(
            child: Icon(
              FlutterRemix.notification_fill,
              color: primaryColor,
              size: 16.w,
            ),
          ),
        ),
        title: StreamBuilder(
            stream: Stream.periodic(const Duration(seconds: 1)),
            builder: (context, snapshot) {
              return Text(
                  "${DateFormat.yMMMMd().format(DateTime.now())} | ${DateFormat.jm().format(DateTime.now())} | Kathmandu",
                  style: GoogleFonts.mulish(
                      color: Color(0xff4f4f4f),
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      height: 1.25));
            }),
        actions: [
          Obx(
            () => authController.isLoading.value
                ? CircularProgressIndicator.adaptive(
                    backgroundColor: secondaryColor,
                  )
                : GestureDetector(
                    onTap: () {
                      if (authenticationManager.isLogged.value) {
                        bottomNavController.currentIndex.value = 3;
                      } else {
                        Get.to(LoginPage());
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: Row(children: [
                        Icon(
                          FlutterRemix.account_circle_fill,
                          color: primaryColor,
                          size: 20.sp,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          authenticationManager.isLogged.value
                              ? authController.user.value?.firstName ?? ""
                              : "Login",
                          style: GoogleFonts.mulish(
                              color: textPrimary, fontSize: 16.sp),
                        ),
                      ]),
                    ),
                  ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            margin: EdgeInsets.only(top: 20.h),
            child: Text(
              "Going To",
              style: GoogleFonts.mulish(
                  fontSize: 16.sp, fontWeight: FontWeight.w600, height: 1.25),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.bottomSheet(
                SearchFilter(),
                barrierColor: primaryColor.withOpacity(.1),
                isDismissible: false,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.w),
                ),
                enableDrag: true,
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Container(
                height: 50.w,
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xff00A5F4).withOpacity(.25),
                          blurRadius: 10)
                    ],
                    borderRadius: BorderRadius.circular(10.w)),
                child: Row(
                  children: [
                    Icon(
                      FlutterRemix.search_line,
                      color: primaryColor,
                      size: 14.w,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      "Where you going ?",
                      style: GoogleFonts.mulish(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: primaryColor.withOpacity(.4),
                          height: 1.25),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Featured Hotels",
                            style: GoogleFonts.mulish(
                                fontSize: 16.sp,
                                color: textPrimary,
                                fontWeight: FontWeight.w600,
                                height: 1.25),
                          ),
                          // GestureDetector(
                          //   onTap: () {},
                          //   child: Container(
                          //     padding: EdgeInsets.only(right: 20.w),
                          //     child: Row(
                          //       children: [
                          //         Text(
                          //           "View All",
                          //           style: GoogleFonts.mulish(
                          //             color: Color(0xff828282),
                          //             fontSize: 14.sp,
                          //             height: 1.2,
                          //           ),
                          //         ),
                          //         Icon(
                          //           FlutterRemix.arrow_right_line,
                          //           color: Color(0xff828282),
                          //           size: 12.w,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                    height: 230.h,
                    margin: EdgeInsets.only(top: 10.h),
                    padding: EdgeInsets.only(left: 10.w),
                    child: Obx(
                      () => ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => HotelCard(
                              hotel: hotelController.featured.value[index]),
                          separatorBuilder: (context, index) => SizedBox(
                                width: 14.w,
                              ),
                          itemCount: hotelController.featured.value.length),
                    )),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Special Offers",
                        style: GoogleFonts.mulish(
                            fontSize: 16.sp,
                            color: textPrimary,
                            fontWeight: FontWeight.w600,
                            height: 1.25),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.w),
                        child: Image.asset(
                          "assets/images/offer.jpg",
                          fit: BoxFit.cover,
                          width: 385.w,
                          height: 160.h,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Most Popular",
                            style: GoogleFonts.mulish(
                                fontSize: 16.sp,
                                color: textPrimary,
                                fontWeight: FontWeight.w600,
                                height: 1.25),
                          ),
                          // GestureDetector(
                          //   onTap: () {},
                          //   child: Container(
                          //     padding: EdgeInsets.only(right: 20.w),
                          //     child: Row(
                          //       children: [
                          //         Text(
                          //           "View All",
                          //           style: GoogleFonts.mulish(
                          //             color: Color(0xff828282),
                          //             fontSize: 14.sp,
                          //             height: 1.2,
                          //           ),
                          //         ),
                          //         Icon(
                          //           FlutterRemix.arrow_right_line,
                          //           color: Color(0xff828282),
                          //           size: 12.w,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 230.h,
                  margin: EdgeInsets.only(top: 10.h),
                  padding: EdgeInsets.only(left: 10.w),
                  child: Obx(
                    () => ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => HotelCard(
                              hotel: hotelController.popular.value[index],
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 14.w,
                            ),
                        itemCount: hotelController.popular.value.length),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
