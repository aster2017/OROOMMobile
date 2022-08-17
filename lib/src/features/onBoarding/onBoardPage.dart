import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/core/constants/colors.dart';

class OnBoardPage extends StatelessWidget {
  final String title, description, image;
  OnBoardPage(
      {Key? key,
      required this.title,
      required this.description,
      required this.image})
      : super(key: key);
  double height = 0;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/$image.png",
          height: 300.h,
          width: 300.w,
        ),
        SizedBox(
          height: 15.h,
        ),
        SizedBox(
          width: 225.w,
          child: Text(
            title,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            style: GoogleFonts.mulish(
                fontSize: 20.sp, height: 1.2, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        SizedBox(
          width: 280.w,
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12.sp,
                height: 1.3,
                fontWeight: FontWeight.w500,
                color: textPrimary.withOpacity(.3)),
          ),
        )
      ],
    );
  }
}
