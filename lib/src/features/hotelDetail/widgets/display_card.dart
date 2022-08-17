import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/colors.dart';

class DisplayCard extends StatefulWidget {
  const DisplayCard({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);
  final String title, description;

  @override
  State<DisplayCard> createState() => _DisplayCardState();
}

class _DisplayCardState extends State<DisplayCard> {
  bool showAll = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.symmetric(
              horizontal: BorderSide(color: Color(0xffF2F2F2)))),
      margin: EdgeInsets.symmetric(vertical: 6.h),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                showAll = !showAll;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.mulish(
                        fontSize: 14.sp,
                        color: textPrimary,
                        fontWeight: FontWeight.w500,
                        height: 1.25),
                  ),
                  Expanded(
                      child: Container(
                    color: Colors.transparent,
                  )),
                  Icon(showAll
                      ? FlutterRemix.arrow_drop_down_line
                      : FlutterRemix.arrow_drop_right_line)
                ],
              ),
            ),
          ),
          showAll
              ? Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                  margin: EdgeInsets.only(top: 12.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.w),
                      color: Color(0xffF2f2f2)),
                  child: Text(
                    widget.description,
                    style: GoogleFonts.mulish(
                        fontSize: 12.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        height: 1.25),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
