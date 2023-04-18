import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:orb/src/features/hotelDetail/views/review_all.dart';
import 'package:orb/src/features/hotelDetail/widgets/review_card.dart';

import '../../../core/authentication_manager.dart';
import '../../../core/constants/colors.dart';
import '../../home/models/hotel_detail.dart';

class ReviewList extends StatefulWidget {
  const ReviewList(
      {Key? key,
      this.reviews = const [],
      required this.reviewAdd,
      required this.hotelUri})
      : super(key: key);
  final List<LatestReview> reviews;
  final String hotelUri;
  final void Function() reviewAdd;
  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  bool showAll = false;
  final AuthenticationManager authenticationManager =
      Get.find<AuthenticationManager>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.symmetric(
              horizontal: BorderSide(color: Color(0xffF2F2F2)))),
      padding: EdgeInsets.symmetric(vertical: 16.h),
      margin: EdgeInsets.symmetric(vertical: 6.h),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                showAll = !showAll;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Latest Review",
                  style: GoogleFonts.mulish(
                      fontSize: 16.sp,
                      color: textPrimary,
                      fontWeight: FontWeight.w600,
                      height: 1.25),
                ),
                Icon(showAll
                    ? FlutterRemix.arrow_drop_down_line
                    : FlutterRemix.arrow_drop_right_line)
              ],
            ),
          ),
          showAll
              ? Column(
                  children: [
                    SizedBox(
                      height: 6.h,
                    ),
                    authenticationManager.isLogged.value
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(ReviewAllPage(
                                    reviews: widget.reviews,
                                    listAllPage: true,
                                    addReview: true,
                                    reviewAdd: () {
                                      widget.reviewAdd.call();
                                    },
                                    hotelUri: widget.hotelUri,
                                  ));
                                },
                                child: Row(
                                  children: [
                                    Icon(FlutterRemix.chat_new_fill),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Add Your Review",
                                      style: GoogleFonts.mulish(
                                          fontSize: 14.sp,
                                          color: textPrimary,
                                          fontWeight: FontWeight.w500,
                                          height: 1.25),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.separated(
                            padding: EdgeInsets.only(top: 8.h),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => ReviewCard(
                                name:
                                    "${widget.reviews[index].firstName ?? ""} ${widget.reviews[index].lastName ?? ""}",
                                rating: widget.reviews[index].rating ?? 0,
                                date: DateFormat.yMMMd()
                                    .format(widget.reviews[index].createdDate!),
                                description:
                                    widget.reviews[index].review ?? '''-'''),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 15.h,
                                ),
                            itemCount: widget.reviews.length > 4
                                ? 4
                                : widget.reviews.length)),
                    widget.reviews.length > 4
                        ? GestureDetector(
                            onTap: () {
                              Get.to(ReviewAllPage(
                                reviews: widget.reviews,
                                listAllPage: true,
                                reviewAdd: () {
                                  widget.reviewAdd.call();
                                },
                                hotelUri: widget.hotelUri,
                              ));
                            },
                            child: Container(
                              width: 110.w,
                              height: 34.h,
                              margin: EdgeInsets.only(top: 8.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.w),
                                  color: primaryColor),
                              child: Center(
                                child: Text(
                                  "See All",
                                  style: GoogleFonts.mulish(
                                      color: whiteColor,
                                      height: 1.4,
                                      fontSize: 16.sp),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
