import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:orb/src/features/home/models/hotel_detail.dart';
import 'package:orb/src/features/hotelDetail/views/room_list.dart';
import 'package:orb/src/features/hotelDetail/widgets/review_list.dart';
import 'package:orb/src/features/hotelDetail/widgets/shimmer_body.dart';
import 'package:orb/src/features/hotelDetail/widgets/swiper.dart';

import '../../../core/constants/colors.dart';
import '../../home/controller/hotel_controller.dart';
import '../../home/controller/search_controller.dart';
import '../widgets/display_card.dart';

class HotelDetail extends StatefulWidget {
  const HotelDetail({Key? key, this.hotelUri = "HotelMarbel"})
      : super(key: key);
  final String hotelUri;
  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

final SearchController searchController = Get.put(SearchController());
final HotelController hotelController = Get.find<HotelController>();

class _HotelDetailState extends State<HotelDetail> {
  List<Map<String, dynamic>> facilities = [
    {"icon": FlutterRemix.restaurant_line, "title": "Restaurant"},
    {"icon": FlutterRemix.parking_line, "title": "Parking"},
  ];
  late HotelDetailModel? hotel;
  @override
  void initState() {
    super.initState();
    fetchHotelData();
  }

  fetchHotelData() {
    hotelController
        .getHotelDetail(
            uri: widget.hotelUri,
            checkIn: DateFormat("yyyy-MM-dd")
                .format(searchController.checkinDate.value),
            checkOut: DateFormat("yyyy-MM-dd")
                .format(searchController.checkOutDate.value))
        .then((value) => setState(() {
              hotel = value;
            }));
  }

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
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                FlutterRemix.heart_line,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                FlutterRemix.share_line,
              ))
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Obx(() => hotelController.fetchHotel.value
            ? displayShimmerBody
            : displayBody(context)),
      ),
    );
  }

  Widget displayBody(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 320.h,
          child: SwiperWidget(
            images: const [
              "assets/images/hotel.jpg",
              "assets/images/hotel1.jpg",
              "assets/images/hotel2.jpg"
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
                  Row(
                    children: [
                      Icon(
                        FlutterRemix.map_pin_2_fill,
                        color: secondaryColor,
                        size: 12.w,
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        hotel!.location ?? "",
                        style: GoogleFonts.mulish(
                          color: Color(0xff828282),
                          fontSize: 12.sp,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    hotel!.hotelName ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.mulish(
                        fontSize: 16.sp,
                        color: textPrimary,
                        fontWeight: FontWeight.w600,
                        height: 1.25),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Row(
                    children: [
                      ...[1, 2, 3, 4, 5].map((e) => Icon(
                            FlutterRemix.star_fill,
                            size: 14.w,
                            color:
                                e == 5 ? Color(0xffbdbdbd) : Color(0xfff2c94c),
                          ))
                    ],
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
                                  hotel!.hotelFacilities![index].facilityIcon ==
                                          null
                                      ? Icon(
                                          FlutterRemix.restaurant_line,
                                          size: 18.w,
                                        )
                                      : Image.network(
                                          hotel!.hotelFacilities![index]
                                              .facilityIcon!,
                                          width: 18.w,
                                        ),
                                  Text(
                                    hotel!.hotelFacilities![index]
                                            .facilityName ??
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
                          itemCount: facilities.length)),
                  SizedBox(
                    height: 14.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Booking Dates And Details",
                        style: GoogleFonts.mulish(
                            fontSize: 14.sp,
                            color: textPrimary,
                            fontWeight: FontWeight.w500,
                            height: 1.25),
                      ),
                      Text(
                        "Change",
                        style: GoogleFonts.mulish(
                            fontSize: 12.sp,
                            color: redColor,
                            fontWeight: FontWeight.w600,
                            height: 1.25),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      bookingDetails("Check In - After 12 PM", "July 31, 2022"),
                      bookingDetails(
                          "Check Out - Before 11 AM", "August 02, 2022"),
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  DisplayCard(
                    title: "Description",
                    description: hotel!.description ??
                        '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis sed venenatis odio arcu. Vestibulum non est, at ultricies nulla lectus nunc, turpis. Pretium nisi etiam pulvinar at fusce pellentesque viverra id. Fermentum ornare id dolor sodales varius etiam sed. ''',
                  ),
                  DisplayCard(
                    title: "Policy",
                    description: hotel!.privacy ??
                        '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis sed venenatis odio arcu. Vestibulum non est, at ultricies nulla lectus nunc, turpis. Pretium nisi etiam pulvinar at fusce pellentesque viverra id. Fermentum ornare id dolor sodales varius etiam sed. ''',
                  ),
                  ReviewList(),
                  DisplayCard(
                    title: "Contact Us",
                    description:
                        '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis sed venenatis odio arcu. Vestibulum non est, at ultricies nulla lectus nunc, turpis. Pretium nisi etiam pulvinar at fusce pellentesque viverra id. Fermentum ornare id dolor sodales varius etiam sed. ''',
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width - 32.w,
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                  border: Border.symmetric(
                      horizontal: BorderSide(color: Color(0xffF2F2F2)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "July 31 - August 02",
                    style: GoogleFonts.mulish(
                        fontSize: 14.sp,
                        color: textPrimary,
                        fontWeight: FontWeight.w500,
                        height: 1.25),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(RoomList());
                    },
                    child: Container(
                      width: 150.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.w),
                          color: primaryColor),
                      child: Center(
                        child: Text(
                          "Choose Rooms",
                          style: GoogleFonts.mulish(
                              color: whiteColor, height: 1.4, fontSize: 16.sp),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ))
      ],
    );
  }

  Container bookingDetails(String title, String value) {
    return Container(
      width: 172.w,
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.w),
          border: Border.all(color: Color(0xffBDBDBD))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.mulish(
                fontSize: 12.sp,
                color: Color(0xff4f4f4f),
                fontWeight: FontWeight.w500,
                height: 1.25),
          ),
          SizedBox(
            height: 6.h,
          ),
          Text(
            value,
            style: GoogleFonts.mulish(
                fontSize: 12.sp,
                color: primaryColor,
                fontWeight: FontWeight.w600,
                height: 1.25),
          ),
        ],
      ),
    );
  }
}
