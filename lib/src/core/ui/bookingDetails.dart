import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/core/ui/ageDropdown.dart';
import 'package:orb/src/features/booking/controller/bookingController.dart';
import 'package:orb/src/features/home/controller/search_controller.dart';

import '../constants/colors.dart';

class BookingDetailsRow extends StatefulWidget {
  BookingDetailsRow({Key? key, this.isBookPage = false}) : super(key: key);
  final bool isBookPage;
  @override
  State<BookingDetailsRow> createState() => _BookingDetailsRowState();
}

class _BookingDetailsRowState extends State<BookingDetailsRow> {
  final SearchController searchController = Get.find<SearchController>();
  final BookingController bookingController = Get.find<BookingController>();
  bool showGuests = false;
  @override
  Widget build(BuildContext context) {
    return Obx(() => bookingDetailsRow());
  }

  Widget bookingDetailsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Guests",
                style: GoogleFonts.mulish(
                    color: textPrimary,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    height: 1.2),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            guestsDetails()
          ]),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: Column(children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Rooms",
                style: GoogleFonts.mulish(
                    color: textPrimary,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    height: 1.2),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
                decoration: BoxDecoration(
                    color: primaryColor.withOpacity(.1),
                    borderRadius: BorderRadius.circular(5.h)),
                child: counterWidget(
                    increament: () {
                      if (((searchController.rooms.value <
                              bookingController
                                  .selectedRoom.value!.noOfRooms!) &&
                          (searchController.rooms.value <
                              searchController.adults.value))) {
                        searchController.rooms.value++;
                        if (widget.isBookPage) {
                          bookingController.feeOrDiscount();
                        }
                      }
                    },
                    decreament: () {
                      if (searchController.rooms.value > 1) {
                        searchController.rooms.value--;
                        if (widget.isBookPage) {
                          bookingController.feeOrDiscount();
                        }
                        if (searchController.adults.value >
                            searchController.rooms.value *
                                ((bookingController
                                            .selectedRoom.value!.maxAdults ??
                                        1) +
                                    (bookingController.selectedRoom.value!
                                            .noOfExtraBeds ??
                                        0))) {
                          searchController.adults.value =
                              searchController.rooms.value *
                                  ((bookingController
                                              .selectedRoom.value!.maxAdults ??
                                          1) +
                                      (bookingController.selectedRoom.value!
                                              .noOfExtraBeds ??
                                          0));
                        }
                      }
                    },
                    value: searchController.rooms.value
                        .toString()
                        .padLeft(2, '0')))
          ]),
        ),
      ],
    );
  }

  Widget guestsDetails() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
          decoration: BoxDecoration(
              color: primaryColor.withOpacity(.1),
              borderRadius: BorderRadius.circular(5.h)),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    showGuests = !showGuests;
                  });
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${searchController.adults.value} Adults ${searchController.childrens.value} Children",
                        style: GoogleFonts.mulish(
                            fontSize: 14.sp,
                            height: 1.2,
                            color: Color(0xff828282)),
                      ),
                      Icon(
                        FlutterRemix.arrow_down_s_fill,
                        color: Color(0xff828282),
                        size: 16.w,
                      ),
                    ],
                  ),
                ),
              ),
              showGuests
                  ? Column(
                      children: [
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 12.h, horizontal: 12.w),
                            decoration: BoxDecoration(
                                color: Color(0xff0A85B4).withOpacity(.1),
                                borderRadius: BorderRadius.circular(5.h)),
                            child: counterWidget(
                                increament: () {
                                  if (searchController.adults.value >=
                                      searchController.rooms.value *
                                          ((bookingController.selectedRoom
                                                      .value!.maxAdults ??
                                                  1) +
                                              (bookingController.selectedRoom
                                                      .value!.noOfExtraBeds ??
                                                  0))) {
                                    Get.closeAllSnackbars();
                                    Get.snackbar("Oops",
                                        "No of adults exceeded. Please increase your rooms.",
                                        colorText: whiteColor,
                                        backgroundColor: redColor);
                                  } else {
                                    searchController.adults.value++;
                                    bookingController.feeOrDiscount();
                                  }
                                },
                                decreament: () {
                                  if ((searchController.adults.value > 1) &&
                                      (searchController.adults.value >
                                          searchController.rooms.value)) {
                                    searchController.adults.value--;
                                    bookingController.feeOrDiscount();
                                  }
                                },
                                value: "Adults")),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 12.h, horizontal: 12.w),
                            decoration: BoxDecoration(
                                color: Color(0xff0A85B4).withOpacity(.1),
                                borderRadius: BorderRadius.circular(5.h)),
                            child: counterWidget(
                                increament: () {
                                  searchController.childrens.value++;
                                  searchController.childrensAge.value.add({
                                    "value": null,
                                    "index": searchController
                                        .childrensAge.value.length
                                  });
                                },
                                decreament: () {
                                  if (searchController.childrens.value > 0) {
                                    searchController.childrens.value--;
                                    searchController.childrensAge.value
                                        .removeLast();
                                  }
                                },
                                value: "Children\nAges 0 to 17"))
                      ],
                    )
                  : Container()
            ],
          ),
        ),
        ...searchController.childrensAge.value.map((e) => AgePopup(
            index: e['index'],
            onChange: (value) {
              searchController.childrensAge.value[e['index']] = {
                "value": value,
                "index": e['index']
              };
              searchController.childrensAge.refresh();
            }))
      ],
    );
  }

  Widget counterWidget(
      {required Function increament,
      required Function decreament,
      required String value}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      GestureDetector(
        onTap: () {
          decreament.call();
        },
        child: Container(
          width: 26.w,
          height: 26.w,
          decoration: BoxDecoration(
              color: whiteColor, borderRadius: BorderRadius.circular(2.h)),
          child: Center(
            child: Icon(
              FlutterRemix.subtract_fill,
              size: 12.sp,
            ),
          ),
        ),
      ),
      Text(
        value,
        textAlign: TextAlign.center,
        style: GoogleFonts.mulish(
            color: textPrimary, fontSize: 12.sp, height: 1.2),
      ),
      GestureDetector(
        onTap: () {
          increament.call();
        },
        child: Container(
          width: 26.w,
          height: 26.w,
          decoration: BoxDecoration(
              color: whiteColor, borderRadius: BorderRadius.circular(2.h)),
          child: Center(
            child: Icon(
              FlutterRemix.add_fill,
              size: 12.sp,
            ),
          ),
        ),
      ),
    ]);
  }
}
