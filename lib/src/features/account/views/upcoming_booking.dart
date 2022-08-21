import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/features/account/views/emailList.dart';
import 'package:orb/src/features/account/widgets/cancel_booking.dart';
import 'package:orb/src/features/account/widgets/upcoming_card.dart';

import '../../../core/constants/colors.dart';

class UpcomingBooking extends StatelessWidget {
  const UpcomingBooking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: textPrimary),
          title: Text(
            "Upcoming Bookings",
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UpcomingCard(
                        date: "28, July 2022",
                        title: "Hotel Himalaya",
                        type: "1 Room : Deluxe Room",
                        update: () {},
                        cancel: () {
                          Get.bottomSheet(
                            CancelBookingSheet(),
                            barrierColor: primaryColor.withOpacity(.1),
                            isDismissible: false,
                            isScrollControlled: false,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.w),
                            ),
                            enableDrag: true,
                          );
                        }),
                    UpcomingCard(
                        date: "28, July 2022",
                        title: "Hotel Himalaya",
                        type: "1 Room : Deluxe Room",
                        update: () {},
                        cancel: () {
                          Get.bottomSheet(
                            CancelBookingSheet(),
                            barrierColor: primaryColor.withOpacity(.1),
                            isDismissible: false,
                            isScrollControlled: false,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.w),
                            ),
                            enableDrag: true,
                          );
                        }),
                    EmailList(),
                  ]),
            ),
          )
        ]));
  }
}
