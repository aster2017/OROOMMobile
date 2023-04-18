import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/core/authentication_manager.dart';
import 'package:orb/src/core/constants/colors.dart';
import 'package:orb/src/core/controller/auth_controller.dart';
import 'package:orb/src/features/booking/views/booking.dart';
import 'package:orb/src/features/home/models/hotel_detail.dart';
import 'package:orb/src/features/hotelDetail/views/hotel_detail.dart';
import 'package:orb/src/features/hotelDetail/views/room_detail.dart';
import 'package:orb/src/features/hotelDetail/widgets/swiper.dart';
import 'package:orb/src/features/login/views/login.dart';

import '../../booking/controller/bookingController.dart';

class RoomCard extends StatefulWidget {
  const RoomCard(
      {Key? key,
      required this.room,
      required this.hotelUri,
      required this.hotel})
      : super(key: key);
  final ChooseYourRoom room;

  final HotelDetailModel hotel;
  final String hotelUri;
  @override
  State<RoomCard> createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  bool favourite = false;
  final BookingController bookingController = Get.find<BookingController>();
  final AuthenticationManager authController =
      Get.find<AuthenticationManager>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(RoomDetail(room: widget.room, hotel: widget.hotel));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.w),
        child: Container(
          margin: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color(0xff000000).withOpacity(.15), blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(10.w),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.w)),
                child: SizedBox(
                  height: 160.h,
                  child: SwiperWidget(
                    networkImages: widget.room.roomCategoryImages!.isNotEmpty
                        ? [
                            ...widget.room.roomCategoryImages!
                                .map((e) => e.imageUrl!)
                          ]
                        : [],
                    images: const [
                      "assets/images/room1.jpg",
                      "assets/images/room2.jpg",
                      "assets/images/room3.jpg"
                    ],
                    bottom: 2.h,
                    height: 160.h,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(6.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.room.roomCategory ?? "",
                          style: GoogleFonts.mulish(
                            color: textPrimary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Room Availability -> ",
                              style: GoogleFonts.mulish(
                                color: textPrimary,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                height: 1.2,
                              ),
                            ),
                            Text(
                              widget.room.noOfRooms.toString(),
                              style: GoogleFonts.mulish(
                                color: primaryColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Wrap(
                      children: [
                        ...widget.room.roomCategoryAmenities!.map((e) =>
                            widget.room.roomCategoryAmenities!.indexOf(e) > 3
                                ? Container()
                                : Container(
                                    width: 170.w,
                                    margin: EdgeInsets.symmetric(vertical: 6.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        e.amenitiesIcon == null ||
                                                e.amenitiesIcon!.isEmpty ||
                                                e.amenitiesIcon! == "string" ||
                                                e.amenitiesIcon! == "fav-icon"
                                            ? Icon(
                                                FlutterRemix.check_line,
                                                size: 18.w,
                                              )
                                            : Icon(
                                                IconDataSolid(int.parse(
                                                    '0x${e.amenitiesIcon}')),
                                                size: 18.w,
                                              ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Text(
                                          e.amenitiesName ?? "",
                                          style: GoogleFonts.mulish(
                                              fontSize: 12.sp,
                                              color: Color(0xff4f4f4f),
                                              fontWeight: FontWeight.w400,
                                              height: 1.25),
                                        )
                                      ],
                                    ),
                                  ))
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              Container(
                decoration: BoxDecoration(
                  color: checkboxColor,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10.w)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      textAlign: TextAlign.right,
                      text: TextSpan(children: [
                        TextSpan(
                          text: "RS. ",
                          style: GoogleFonts.mulish(
                              fontSize: 12.sp,
                              color: textPrimary,
                              fontWeight: FontWeight.w600,
                              height: 1.25),
                        ),
                        TextSpan(
                          text: widget.room.minProductCost!.toString(),
                          style: GoogleFonts.mulish(
                              fontSize: 12.sp,
                              color: redColor,
                              fontWeight: FontWeight.w700,
                              decoration: widget.room.minPrice! <
                                      widget.room.minProductCost!
                                  ? TextDecoration.lineThrough
                                  : null,
                              height: 1.25),
                        ),
                        if (widget.room.minPrice! < widget.room.minProductCost!)
                          TextSpan(
                            text: widget.room.minPrice!.toString(),
                            style: GoogleFonts.mulish(
                                fontSize: 14.sp,
                                color: secondaryColor,
                                fontWeight: FontWeight.w700,
                                height: 1.25),
                          ),
                        TextSpan(
                          text: " per day\n",
                          style: GoogleFonts.mulish(
                              fontSize: 12.sp,
                              color: textPrimary,
                              fontWeight: FontWeight.w600,
                              height: 1.25),
                        ),
                        TextSpan(
                          text: "Includes taxes and fees",
                          style: GoogleFonts.mulish(
                              fontSize: 10.sp,
                              color: Color(0xff4f4f4f),
                              fontWeight: FontWeight.w400,
                              height: 1.25),
                        )
                      ]),
                    ),
                    GestureDetector(
                      onTap: () {
                        if ((widget.room.noOfRooms ?? 0) < 1) {
                          Get.snackbar("Oops", "No room available now.",
                              colorText: whiteColor, backgroundColor: redColor);
                        } else {
                          bookingController.selectedRoom.value = widget.room;
                          bookingController.hotel.value = widget.hotelUri;
                          authController.isLogged.value
                              ? Get.to(BookPage())
                              : Get.to(LoginPage(isBooking: true));
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        height: 24.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.w),
                            color: secondaryColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Select Room",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.mulish(
                                  color: whiteColor,
                                  height: 1,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              FlutterRemix.arrow_drop_right_line,
                              size: 12.w,
                              color: whiteColor,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
