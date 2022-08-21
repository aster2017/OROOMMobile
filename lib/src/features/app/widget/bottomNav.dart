import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:orb/src/core/constants/colors.dart';
import 'package:orb/src/core/ui/footer.dart';
import 'package:orb/src/features/app/controller/bottom_nav.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  BottomNavigationBarWidget({Key? key}) : super(key: key);
  final BottomNavController bottomNavController =
      Get.find<BottomNavController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 118,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              removeTop: true,
              child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  enableFeedback: true,
                  selectedItemColor: primaryColor,
                  unselectedItemColor: textPrimary.withOpacity(.7),
                  currentIndex: bottomNavController.currentIndex.value,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Ink(
                          child: Column(
                        children: [
                          bottomNavController.currentIndex.value == 0
                              ? Container(
                                  height: 4,
                                  width: 46,
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(4.w))),
                                )
                              : Container(),
                          SizedBox(
                            height: 10,
                          ),
                          Icon(FlutterRemix.home_7_fill),
                          Text(
                            "Home",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color:
                                    bottomNavController.currentIndex.value == 0
                                        ? primaryColor
                                        : Color(0xff303030).withOpacity(.3)),
                          ),
                        ],
                      )),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: Ink(
                          child: Column(
                        children: [
                          bottomNavController.currentIndex.value == 1
                              ? Container(
                                  height: 4,
                                  width: 46,
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(4.w))),
                                )
                              : Container(),
                          SizedBox(
                            height: 10,
                          ),
                          Icon(FlutterRemix.compass_3_line),
                          Text(
                            "Explore",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color:
                                    bottomNavController.currentIndex.value == 1
                                        ? primaryColor
                                        : Color(0xff303030).withOpacity(.3)),
                          ),
                        ],
                      )),
                      label: "Explore",
                    ),
                    BottomNavigationBarItem(
                      icon: Ink(
                          child: Column(
                        children: [
                          bottomNavController.currentIndex.value == 2
                              ? Container(
                                  height: 4,
                                  width: 46,
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(4.w))),
                                )
                              : Container(),
                          SizedBox(
                            height: 10,
                          ),
                          Icon(FlutterRemix.heart_line),
                          Text(
                            "Wishlist",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color:
                                    bottomNavController.currentIndex.value == 2
                                        ? primaryColor
                                        : Color(0xff303030).withOpacity(.3)),
                          ),
                        ],
                      )),
                      label: "Wishlist",
                    ),
                    BottomNavigationBarItem(
                      icon: Ink(
                          child: Column(
                        children: [
                          bottomNavController.currentIndex.value == 3
                              ? Container(
                                  height: 4,
                                  width: 46,
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(4.w))),
                                )
                              : Container(),
                          SizedBox(
                            height: 10,
                          ),
                          Icon(FlutterRemix.account_circle_line),
                          Text(
                            "Me",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color:
                                    bottomNavController.currentIndex.value == 3
                                        ? primaryColor
                                        : Color(0xff303030).withOpacity(.3)),
                          ),
                        ],
                      )),
                      label: "Me",
                    ),
                  ],
                  onTap: (value) =>
                      bottomNavController.currentIndex.value = value),
            ),
            FooterWidget(),
          ],
        ),
      ),
    );
  }
}
