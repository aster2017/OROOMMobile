import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/core/authentication_manager.dart';
import 'package:orb/src/features/booking/controller/bookingController.dart';
import 'package:orb/src/features/home/models/hotel_detail.dart';

import '../../../core/constants/colors.dart';
import '../../booking/views/booking.dart';
import '../../home/controller/hotel_controller.dart';
import '../../home/controller/search_controller.dart';
import '../../login/views/login.dart';
import '../widgets/display_card.dart';
import '../widgets/swiper.dart';

class RoomDetail extends StatefulWidget {
  const RoomDetail({Key? key, required this.room, required this.hotel})
      : super(key: key);
  final ChooseYourRoom? room;
  final HotelDetailModel hotel;
  @override
  State<RoomDetail> createState() => _RoomDetailState();
}

final BookingController bookingController = Get.put(BookingController());
final HotelController hotelController = Get.find<HotelController>();
final AuthenticationManager authController = Get.find<AuthenticationManager>();

class _RoomDetailState extends State<RoomDetail> {
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              FlutterRemix.arrow_left_line,
            )),
      ),
      extendBodyBehindAppBar: true,
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: displayBody(context)),
    );
  }

  Widget displayBody(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 320.h,
          child: SwiperWidget(
            networkImages: widget.room!.roomCategoryImages!.isNotEmpty
                ? [
                    ...widget.room!.roomCategoryImages!
                        .map((e) => e['imageUrl'])
                  ]
                : [],
            images: const [
              "assets/images/room1.jpg",
              "assets/images/room2.jpg",
              "assets/images/room3.jpg"
            ],
            bottom: 80.h,
            height: 320.h,
          ),
        ),
        Positioned(
          top: 245.h,
          child: Container(
            width: 428.w,
            height: 600.h,
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(50.w))),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      widget.hotel.hotelName ?? "",
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.mulish(
                          fontSize: 14.sp,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                          height: 1.25),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.room!.roomCategory ?? "",
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.mulish(
                                fontSize: 16.sp,
                                color: textPrimary,
                                fontWeight: FontWeight.w600,
                                height: 1.25),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          RichText(
                              textAlign: TextAlign.right,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "NPR ",
                                    style: GoogleFonts.mulish(
                                        fontSize: 12.sp,
                                        color: textPrimary,
                                        fontWeight: FontWeight.w600,
                                        height: 1.25),
                                  ),
                                  TextSpan(
                                    text: widget.room!.minPrice!.toString(),
                                    style: GoogleFonts.mulish(
                                        fontSize: 12.sp,
                                        color: redColor,
                                        fontWeight: FontWeight.w700,
                                        height: 1.25),
                                  ),
                                  TextSpan(
                                    text: " per day",
                                    style: GoogleFonts.mulish(
                                        fontSize: 12.sp,
                                        color: textPrimary,
                                        fontWeight: FontWeight.w600,
                                        height: 1.25),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          bookingController.selectedRoom.value = widget.room;
                          bookingController.hotel.value =
                              widget.hotel.hotelUri!;
                          authController.isLogged.value
                              ? Get.to(BookPage())
                              : Get.to(LoginPage(isBooking: true));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          height: 24.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.w),
                              color: primaryColor),
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
                  SizedBox(
                    height: 8.h,
                  ),
                  Divider(
                    height: 1,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "Hotel Facilities",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.mulish(
                        fontSize: 14.sp,
                        color: textPrimary,
                        fontWeight: FontWeight.w500,
                        height: 1.25),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  SizedBox(
                      height: 32.h,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Column(
                                children: [
                                  widget.room?.roomCategoryFacilities![index]
                                              ['facilityIcon'] ==
                                          null
                                      ? Icon(
                                          FlutterRemix.restaurant_line,
                                          size: 18.w,
                                        )
                                      : Image.network(
                                          widget.room?.roomCategoryFacilities![
                                              index]['facilityIcon'],
                                          width: 18.w,
                                        ),
                                  Text(
                                    widget.room?.roomCategoryFacilities![index]
                                            ['facilityName'] ??
                                        "",
                                    style: GoogleFonts.mulish(
                                        fontSize: 10.sp,
                                        color: Color(0xff4f4f4f),
                                        fontWeight: FontWeight.w500,
                                        height: 1.25),
                                  )
                                ],
                              ),
                          separatorBuilder: (context, index) => SizedBox(
                                width: 12.w,
                              ),
                          itemCount:
                              widget.room?.roomCategoryFacilities?.length ??
                                  0)),
                  SizedBox(
                    height: 14.h,
                  ),
                  DisplayCard(
                    title: "Description",
                    description:
                        '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis sed venenatis odio arcu. Vestibulum non est, at ultricies nulla lectus nunc, turpis. Pretium nisi etiam pulvinar at fusce pellentesque viverra id. Fermentum ornare id dolor sodales varius etiam sed. ''',
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Text(
                    "Hotel Ameneties",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.mulish(
                        fontSize: 14.sp,
                        color: textPrimary,
                        fontWeight: FontWeight.w500,
                        height: 1.25),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  SizedBox(
                      height: 32.h,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Column(
                                children: [
                                  widget.room?.roomCategoryFacilities![index]
                                              ['facilityIcon'] ==
                                          null
                                      ? Icon(
                                          FlutterRemix.restaurant_line,
                                          size: 18.w,
                                        )
                                      : Image.network(
                                          widget.room?.roomCategoryFacilities![
                                              index]['facilityIcon'],
                                          width: 18.w,
                                        ),
                                  Text(
                                    widget.room?.roomCategoryFacilities![index]
                                            ['facilityName'] ??
                                        "",
                                    style: GoogleFonts.mulish(
                                        fontSize: 10.sp,
                                        color: Color(0xff4f4f4f),
                                        fontWeight: FontWeight.w500,
                                        height: 1.25),
                                  )
                                ],
                              ),
                          separatorBuilder: (context, index) => SizedBox(
                                width: 12.w,
                              ),
                          itemCount:
                              widget.room?.roomCategoryFacilities?.length ??
                                  0)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
