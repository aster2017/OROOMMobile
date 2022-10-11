import 'dart:math';
import 'dart:ui';

import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/core/constants/colors.dart';
import 'package:orb/src/features/hotelDetail/views/hotel_detail.dart';

class RatingPopup extends StatefulWidget {
  RatingPopup({Key? key, this.onMoodChange, this.selectedMood})
      : super(key: key);
  final void Function(int)? onMoodChange;
  final int? selectedMood;

  @override
  State<RatingPopup> createState() => _RatingPopupState();
}

class _RatingPopupState extends State<RatingPopup> {
  List<Map<String, dynamic>> menuItems = [
    {"title": "1 Star", "value": 1},
    {"title": "2 Star", "value": 2},
    {"title": "3 Star", "value": 3},
    {"title": "4 Star", "value": 4},
    {"title": "5 Star", "value": 5},
  ];

  final CustomPopupMenuController _controller = CustomPopupMenuController();

  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
      showArrow: false,
      position: PreferredPosition.top,
      menuBuilder: () => ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.w),
            bottomLeft: Radius.circular(10.w),
            bottomRight: Radius.circular(10.w)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.w),
                  bottomLeft: Radius.circular(10.w),
                  bottomRight: Radius.circular(10.w)),
              color: Color.fromRGBO(247, 248, 250, 0.2),
            ),
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: menuItems
                    .map(
                      (item) => GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () async {
                          if (searchController.ratings
                              .contains(item['value'])) {
                            searchController.ratings.remove(item['value']);
                          } else {
                            searchController.ratings.add(item['value']);
                          }
                          searchController.ratings.refresh();
                          // _controller.hideMenu();
                          // await Future.delayed(Duration(milliseconds: 500));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 3.h, horizontal: 12.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 8.h),
                          // decoration: BoxDecoration(
                          //     color: Color.fromRGBO(247, 248, 250, 0.5),
                          //     borderRadius: BorderRadius.circular(5)),
                          child: Obx(
                            () => Row(
                              children: [
                                SizedBox(
                                  width: 14.sp,
                                  height: 14.sp,
                                  child: Checkbox(
                                    activeColor: secondaryColor,
                                    checkColor: whiteColor,
                                    side: BorderSide(color: secondaryColor),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    value: searchController.ratings
                                        .contains(item['value']),
                                    onChanged: (value) {
                                      if (searchController.ratings
                                          .contains(item['value'])) {
                                        searchController.ratings
                                            .remove(item['value']);
                                      } else {
                                        searchController.ratings
                                            .add(item['value']);
                                      }
                                      searchController.ratings.refresh();
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  item['title'],
                                  style: GoogleFonts.workSans(
                                    color: Colors.black.withOpacity(0.7),
                                    height: 1.25,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
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
      pressType: PressType.singleClick,
      verticalMargin: 2,
      controller: _controller,
      arrowColor: Theme.of(context).scaffoldBackgroundColor,
      child: Obx(
        () => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 14.sp,
              height: 14.sp,
              child: Checkbox(
                activeColor: secondaryColor,
                checkColor: whiteColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                side: BorderSide(color: secondaryColor),
                value: searchController.ratings.isNotEmpty,
                onChanged: (value) {},
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              "Ratings",
              style: GoogleFonts.workSans(
                color: textPrimary,
                height: 1.25,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
