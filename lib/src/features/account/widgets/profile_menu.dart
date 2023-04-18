import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/colors.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu(
      {Key? key, required this.title, required this.onTap, this.icon})
      : super(key: key);
  final String title;
  final Function onTap;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap.call();
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.symmetric(
                horizontal: BorderSide(color: Color(0xffF2F2F2)))),
        margin: EdgeInsets.symmetric(vertical: 6.h),
        child: Column(children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                icon == null
                    ? Container()
                    : Icon(
                        icon,
                        color: textPrimary,
                        size: 18.sp,
                      ),
                icon == null
                    ? Container()
                    : SizedBox(
                        width: 8.w,
                      ),
                Text(
                  title,
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
                Icon(FlutterRemix.arrow_drop_right_line)
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
