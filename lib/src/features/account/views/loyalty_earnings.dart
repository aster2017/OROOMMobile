import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:orb/src/features/account/controller/myBooking.dart';
import 'package:orb/src/features/account/widgets/loyalty_card.dart';

import '../../../core/constants/colors.dart';
import '../../booking/controller/bookingController.dart';

class LoyaltyEarningsView extends StatelessWidget {
  LoyaltyEarningsView({Key? key}) : super(key: key);
  MyBookingController myBookingController = Get.find<MyBookingController>();
  final BookingController bookingController = Get.find<BookingController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: textPrimary),
          title: Text(
            "Loyalty Earnings",
            style: GoogleFonts.mulish(
                color: textPrimary, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Column(children: [
          Divider(
            height: 2,
            color: Color(0xfff2f2f2),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Obx(
                () => SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          myBookingController.loyaltyEarnings.value.isEmpty
                              ? []
                              : [
                                  ...myBookingController.loyaltyEarnings.value
                                      .map((e) => LoyaltyCard(
                                            date: e.earnedDate == null
                                                ? ""
                                                : DateFormat.yMMMMd()
                                                    .format(e.earnedDate!),
                                            title: e.hotelName ?? "",
                                            loyaltyEarnings: e,
                                          )),
                                  // EmailList(),
                                ]),
                ),
              ),
            ),
          )
        ]));
  }
}
