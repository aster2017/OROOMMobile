import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  DateTime currentDate = DateTime.now();
  HotelDetailModel? hotel;
  @override
  void initState() {
    super.initState();
    fetchHotelData();
  }

  fetchHotelData({bool loading = true}) {
    hotelController
        .getHotelDetail(
            uri: widget.hotelUri,
            checkIn: DateFormat("yyyy-MM-dd")
                .format(searchController.checkinDate.value),
            checkOut: DateFormat("yyyy-MM-dd")
                .format(searchController.checkOutDate.value),
            loading: loading)
        .then((value) {
      if (mounted) {
        setState(() {
          hotel = value;
        });
      }
    });
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
          // IconButton(
          //     onPressed: () {},
          //     icon: Icon(
          //       FlutterRemix.heart_line,
          //     )),
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
            // networkImages:[]
            networkImages: hotel == null || hotel!.hotelImage!.isEmpty
                ? []
                : [...hotel!.hotelImage!.map((e) => e.imageUrl!)],
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
                        hotel?.location ?? "",
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
                    hotel?.hotelName ?? "",
                    overflow: TextOverflow.visible,
                    style: GoogleFonts.mulish(
                        fontSize: 16.sp,
                        color: textPrimary,
                        fontWeight: FontWeight.w600,
                        height: 1.25),
                  ),
                  // SizedBox(
                  //   height: 6.h,
                  // ),
                  // RatingBar.builder(
                  //                     ignoreGestures: false,
                  //                     itemSize: 20.sp,
                  //                     initialRating: hotel?.,
                  //                     minRating: 1,
                  //                     direction: Axis.horizontal,
                  //                     allowHalfRating: true,
                  //                     unratedColor: greyColor,
                  //                     itemCount: 5,
                  //                     itemPadding: EdgeInsets.only(right: 1),
                  //                     itemBuilder: (context, _) => Icon(
                  //                       Icons.star,
                  //                       color: Colors.amber,
                  //                     ),
                  //                     onRatingUpdate: (val) {
                  //                       setState(() {
                  //                         rating = val;
                  //                       });
                  //                     },
                  //                   )
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
                      height: 45.h,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Container(
                                width: 45.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    hotel?.hotelFacilities![index]
                                                    .facilityIcon ==
                                                null ||
                                            hotel!.hotelFacilities![index]
                                                .facilityIcon!.isEmpty ||
                                            hotel?.hotelFacilities![index]
                                                    .facilityIcon ==
                                                "string" ||
                                            hotel?.hotelFacilities![index]
                                                    .facilityIcon ==
                                                "fav-icon"
                                        ? Icon(
                                            FlutterRemix.check_line,
                                            size: 18.w,
                                          )
                                        : Icon(
                                            IconDataSolid(int.parse(
                                                '0x${hotel?.hotelFacilities![index].facilityIcon}')),
                                            size: 18.w,
                                          ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Text(
                                      hotel!.hotelFacilities![index]
                                              .facilityName ??
                                          "",
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      softWrap: true,
                                      style: GoogleFonts.mulish(
                                          fontSize: 10.sp,
                                          color: Color(0xff4f4f4f),
                                          fontWeight: FontWeight.w500,
                                          height: 1.25),
                                    )
                                  ],
                                ),
                              ),
                          separatorBuilder: (context, index) => SizedBox(
                                width: 12.w,
                              ),
                          itemCount: hotel?.hotelFacilities?.length ?? 0)),
                  SizedBox(
                    height: 14.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Booking Dates And Details",
                        style: GoogleFonts.mulish(
                            fontSize: 14.sp,
                            color: textPrimary,
                            fontWeight: FontWeight.w500,
                            height: 1.25),
                      ),
                      // Text(
                      //   "Change",
                      //   style: GoogleFonts.mulish(
                      //       fontSize: 12.sp,
                      //       color: redColor,
                      //       fontWeight: FontWeight.w600,
                      //       height: 1.25),
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await _selectDate(context);
                            fetchHotelData(loading: false);
                          },
                          child: bookingDetails(
                              "Check In - After 12 PM",
                              DateFormat.yMMMd()
                                  .format(searchController.checkinDate.value)),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await _selectDate(context, isFrom: false);
                            fetchHotelData(loading: false);
                          },
                          child: bookingDetails(
                              "Check Out - Before 11 AM",
                              DateFormat.yMMMd()
                                  .format(searchController.checkOutDate.value)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  DisplayCard(
                    title: "Description",
                    description: hotel?.description ?? "-",
                    isHtml: true,
                  ),
                  DisplayCard(
                      title: "Policy",
                      description: hotel?.privacy ?? "-",
                      isHtml: true),
                  ReviewList(
                    reviews: hotel?.latestReview == null
                        ? []
                        : List.from(hotel!.latestReview!.reversed),
                    hotelUri: hotel?.hotelUri! ?? "",
                    reviewAdd: () {
                      fetchHotelData(loading: false);
                    },
                  ),
                  // DisplayCard(
                  //   title: "Contact Us",
                  //   description:
                  //       '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis sed venenatis odio arcu. Vestibulum non est, at ultricies nulla lectus nunc, turpis. Pretium nisi etiam pulvinar at fusce pellentesque viverra id. Fermentum ornare id dolor sodales varius etiam sed. ''',
                  // ),
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
                    "${DateFormat.MMMMd().format(searchController.checkinDate.value)} - ${DateFormat.MMMd().format(searchController.checkOutDate.value)}",
                    style: GoogleFonts.mulish(
                        fontSize: 14.sp,
                        color: textPrimary,
                        fontWeight: FontWeight.w500,
                        height: 1.25),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(RoomList(
                          hotelUri: hotel!.hotelUri!,
                          rooms: hotel!.chooseYourRoom!,
                          hotel: hotel!));
                    },
                    child: Container(
                      width: 150.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22.h),
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

  Future<void> _selectDate(BuildContext context, {bool isFrom = true}) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: (isFrom
            ? searchController.checkinDate.value
            : searchController.checkOutDate.value
                        .difference(searchController.checkinDate.value)
                        .inDays <
                    1
                ? searchController.checkinDate.value.add(Duration(days: 1))
                : searchController.checkOutDate.value),
        fieldHintText: isFrom ? "Check In Date" : "Check Out Date",
        initialDatePickerMode: DatePickerMode.day,
        firstDate: isFrom
            ? currentDate
            : searchController.checkinDate.value.add(Duration(days: 1)),
        lastDate: currentDate.add(Duration(days: 30)));

    if (picked != null &&
        picked !=
            (isFrom
                ? searchController.checkinDate.value
                : searchController.checkOutDate.value)) {
      if (isFrom) {
        if (searchController.checkOutDate.value.difference(picked).inDays < 1) {
          searchController.checkOutDate.value = picked.add(Duration(days: 1));
        }
        searchController.checkinDate.value = picked;
      } else {
        searchController.checkOutDate.value = picked;
      }
    }
  }
}
