import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/colors.dart';

class DisplayCard extends StatefulWidget {
  const DisplayCard(
      {Key? key,
      required this.title,
      required this.description,
      this.isHtml = false})
      : super(key: key);
  final String title, description;
  final bool isHtml;

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
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                showAll = !showAll;
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  widget.title,
                  style: GoogleFonts.mulish(
                      fontSize: 16.sp,
                      color: textPrimary,
                      fontWeight: FontWeight.w600,
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
          showAll
              ? Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                  margin: EdgeInsets.only(top: 12.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.w),
                      color: Color(0xffF2f2f2)),
                  child: widget.isHtml
                      ? Html(
                          data: widget.description,
                          style: {
                            "p": Style(
                                color: Colors.black,
                                fontSize: FontSize(16.sp),
                                fontFamily: "mukta"),
                            "img": Style(width: Width(280.w))
                          },
                          //   style: GoogleFonts.mukta(
                          //       fontSize: 15,
                          //       height: 1.25,
                          //       fontWeight: FontWeight.w400,
                          //       color: textDark),
                          // )
                        )
                      : Text(
                          widget.description,
                          textAlign: TextAlign.left,
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
