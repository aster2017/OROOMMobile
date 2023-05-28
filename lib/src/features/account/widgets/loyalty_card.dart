import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/features/account/data/model/loyalty_earning.dart';
import 'package:orb/src/features/account/data/model/loyalty_used.dart';

import '../../../core/constants/colors.dart';

class LoyaltyCard extends StatelessWidget {
  const LoyaltyCard(
      {Key? key,
      required this.title,
      required this.date,
      this.loyaltyUsed,
      this.loyaltyEarnings})
      : super(key: key);
  final String title, date;
  final LoyaltyUsed? loyaltyUsed;
  final LoyaltyEarnings? loyaltyEarnings;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.symmetric(
              horizontal: BorderSide(color: Color(0xffF2F2F2)))),
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              date,
              style: GoogleFonts.mulish(
                  fontSize: 14.sp,
                  color: Color(0xff4f4f4f),
                  fontWeight: FontWeight.w500,
                  height: 1.25),
            ),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                children: [
                  Text(
                    loyaltyEarnings != null
                        ? "Earned points : "
                        : "Used points : ",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mulish(
                        fontSize: 16.sp,
                        color: textPrimary,
                        fontWeight: FontWeight.w500,
                        height: 1.25),
                  ),
                  Text(
                    loyaltyEarnings != null
                        ? loyaltyEarnings!.loyaltyPoint?.toString() ?? ""
                        : loyaltyUsed!.pointsUsed?.toString() ?? "",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mulish(
                        fontSize: 16.sp,
                        color: textPrimary,
                        fontWeight: FontWeight.bold,
                        height: 1.25),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Amount : ",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mulish(
                      fontSize: 16.sp,
                      color: textPrimary,
                      fontWeight: FontWeight.w500,
                      height: 1.25),
                ),
                Text(
                  loyaltyEarnings != null
                      ? loyaltyEarnings!.loyaltyPointAmount?.toString() ?? ""
                      : loyaltyUsed!.amountUsed?.toString() ?? "",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mulish(
                      fontSize: 16.sp,
                      color: textPrimary,
                      fontWeight: FontWeight.bold,
                      height: 1.25),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
