import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:orb/src/features/account/controller/myBooking.dart';
import 'package:orb/src/features/account/widgets/cancel_booking.dart';
import 'package:orb/src/features/account/widgets/upcoming_card.dart';

import '../../../core/constants/colors.dart';
import '../../booking/controller/bookingController.dart';
import '../../booking/views/invoice.dart';

class UpcomingBooking extends StatelessWidget {
  UpcomingBooking({Key? key}) : super(key: key);
  MyBookingController myBookingController = Get.find<MyBookingController>();
  final BookingController bookingController = Get.find<BookingController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: textPrimary),
          title: Text(
            "My Bookings",
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
                      children: myBookingController.bookings.value.isEmpty
                          ? []
                          : [
                              ...myBookingController.bookings.value.map((e) =>
                                  UpcomingCard(
                                      bookingModel: e,
                                      date: DateFormat.yMMMMd()
                                          .format(e.bookingDateFrom!),
                                      title: e.hotelName!,
                                      type: "${e.noOfRooms} Room",
                                      cancel: () {
                                        Get.bottomSheet(
                                          CancelBookingSheet(),
                                          barrierColor:
                                              primaryColor.withOpacity(.1),
                                          isDismissible: false,
                                          isScrollControlled: false,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.w),
                                          ),
                                          enableDrag: true,
                                        );
                                      },
                                      pay: () async {
                                        await bookingController
                                            .feeOrDiscountBooked(e);
                                        await CreatePdf(myBookingModel: e)
                                            .generateInvoice();
                                      })),
                              // EmailList(),
                            ]),
                ),
              ),
            ),
          )
        ]));
  }
}
