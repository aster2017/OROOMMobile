import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/features/account/widgets/email.dart';

import '../../../core/constants/colors.dart';

class EmailList extends StatefulWidget {
  const EmailList({Key? key}) : super(key: key);

  @override
  State<EmailList> createState() => _EmailListState();
}

class _EmailListState extends State<EmailList> {
  bool showAll = false;
  @override
  Widget build(BuildContext context) {
    return showAll
        ? Expanded(child: bodyContainer(context))
        : bodyContainer(context);
  }

  Container bodyContainer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.symmetric(
              horizontal: BorderSide(color: Color(0xffF2F2F2)))),
      padding: EdgeInsets.symmetric(vertical: 16.h),
      margin: EdgeInsets.symmetric(vertical: 6.h),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                showAll = !showAll;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Email Inbox",
                  style: GoogleFonts.mulish(
                      fontSize: 16.sp,
                      color: textPrimary,
                      fontWeight: FontWeight.w600,
                      height: 1.25),
                ),
                Icon(showAll
                    ? FlutterRemix.arrow_drop_down_line
                    : FlutterRemix.arrow_drop_right_line)
              ],
            ),
          ),
          showAll
              ? Expanded(
                  child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.separated(
                          padding: EdgeInsets.only(top: 8.h),
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) => EmailCard(
                              date: "28, July 2022", title: "Hotel Himalaya"),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 15.h,
                              ),
                          itemCount: 4)),
                )
              : Container()
        ],
      ),
    );
  }
}
