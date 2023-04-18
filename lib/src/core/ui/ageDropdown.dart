import 'dart:math';
import 'dart:ui';

import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/features/home/controller/search_controller.dart';

import '../constants/colors.dart';

class AgePopup extends StatefulWidget {
  AgePopup({Key? key, required this.index, required this.onChange})
      : super(key: key);
  final void Function(String) onChange;
  final int index;

  @override
  State<AgePopup> createState() => _AgePopupState();
}

class _AgePopupState extends State<AgePopup> {
  List<String> menuItems = [
    "Younger than 1",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17"
  ];

  final CustomPopupMenuController _controller = CustomPopupMenuController();

  final SearchController searchController = Get.find<SearchController>();

  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
      showArrow: false,
      menuBuilder: () => ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.w),
            bottomLeft: Radius.circular(10.w),
            bottomRight: Radius.circular(10.w)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            height: 300.h,
            padding: EdgeInsets.symmetric(vertical: 5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.w),
                  bottomLeft: Radius.circular(10.w),
                  bottomRight: Radius.circular(10.w)),
              color: Color.fromRGBO(247, 248, 250, 0.2),
            ),
            child: IntrinsicWidth(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: menuItems
                      .map(
                        (item) => GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () async {
                            widget.onChange.call(item);
                            _controller.hideMenu();
                            // await Future.delayed(Duration(milliseconds: 500));
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            // margin: EdgeInsets.symmetric(
                            //     vertical: 3.h, horizontal: 12.w),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 6.h),
                            // decoration: BoxDecoration(
                            //     color: Color.fromRGBO(247, 248, 250, 0.5),
                            //     borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              item,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.workSans(
                                color: textPrimary,
                                height: 1.25,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ),
      ),
      pressType: PressType.singleClick,
      verticalMargin: 2,
      controller: _controller,
      arrowColor: Theme.of(context).scaffoldBackgroundColor,
      child: Obx(
        () => Container(
          margin: EdgeInsets.symmetric(vertical: 1.h),
          decoration: BoxDecoration(
              color: primaryColor.withOpacity(.1),
              borderRadius: BorderRadius.circular(5.h)),
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${searchController.childrensAge.value[widget.index]['value'] ?? "Select age"} (Child ${widget.index + 1} age)",
                style: GoogleFonts.mulish(
                    fontSize: 14.sp, height: 1.2, color: Color(0xff828282)),
              ),
              Icon(
                FlutterRemix.arrow_down_s_fill,
                color: Color(0xff828282),
                size: 16.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
