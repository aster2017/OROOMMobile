import 'dart:math';
import 'dart:ui';

import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MoodPopup extends StatefulWidget {
  MoodPopup({Key? key, this.onMoodChange, this.selectedMood}) : super(key: key);
  final void Function(int)? onMoodChange;
  final int? selectedMood;

  @override
  State<MoodPopup> createState() => _MoodPopupState();
}

class _MoodPopupState extends State<MoodPopup> {
  List<String> menuItems = [
    "Younger than 1",
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
        showArrow: false,
        position: PreferredPosition.bottom,
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
                                _controller.hideMenu();
                                // await Future.delayed(Duration(milliseconds: 500));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 3.h, horizontal: 12.w),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 8.h),
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(247, 248, 250, 0.5),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  item,
                                  style: GoogleFonts.workSans(
                                    color: Colors.black.withOpacity(0.7),
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
        pressType: PressType.singleClick,
        verticalMargin: 2,
        controller: _controller,
        arrowColor: Theme.of(context).scaffoldBackgroundColor,
        child: Container());
  }
}
