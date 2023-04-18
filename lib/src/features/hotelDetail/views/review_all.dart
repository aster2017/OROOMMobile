import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:orb/src/features/hotelDetail/widgets/post_review.dart';
import 'package:orb/src/features/hotelDetail/widgets/review_card.dart';

import '../../../core/constants/colors.dart';
import '../../home/models/hotel_detail.dart';

class ReviewAllPage extends StatefulWidget {
  const ReviewAllPage(
      {Key? key,
      this.reviews = const [],
      this.listAllPage = false,
      this.addReview = false,
      required this.reviewAdd,
      required this.hotelUri})
      : super(key: key);
  final List<LatestReview> reviews;
  final String hotelUri;
  final bool listAllPage, addReview;
  final void Function() reviewAdd;
  @override
  State<ReviewAllPage> createState() => _ReviewAllPageState();
}

class _ReviewAllPageState extends State<ReviewAllPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: textPrimary),
        title: Text(
          "Reviews",
          style: GoogleFonts.mulish(
              color: textPrimary, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        PostReview(
          addReview: widget.addReview,
          hotelUri: widget.hotelUri,
          reviewAdd: (() {
            widget.reviewAdd.call();
          }),
        ),
        Expanded(
          child: Padding(
              padding: EdgeInsets.all(20.w),
              child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.separated(
                      padding: EdgeInsets.only(top: 8.h),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => ReviewCard(
                          name:
                              "${widget.reviews[index].firstName ?? ""} ${widget.reviews[index].lastName ?? ""}",
                          rating: widget.reviews[index].rating ?? 0,
                          date: DateFormat.yMMMMd()
                              .format(widget.reviews[index].createdDate!),
                          description: widget.reviews[index].review ?? '''-'''),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 15.h,
                          ),
                      itemCount: widget.listAllPage
                          ? widget.reviews.length
                          : widget.reviews.length <= 4
                              ? 4
                              : widget.reviews.length))),
        )
      ]),
    );
  }
}
