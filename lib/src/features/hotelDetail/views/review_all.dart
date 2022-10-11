import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:orb/src/features/hotelDetail/widgets/review_card.dart';

import '../../../core/constants/colors.dart';
import '../../home/models/hotel_detail.dart';

class ReviewAllPage extends StatefulWidget {
  const ReviewAllPage({Key? key, this.reviews = const []}) : super(key: key);
  final List<Review> reviews;
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
        Divider(
          height: 2,
          color: Color(0xfff2f2f2),
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
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => ReviewCard(
                          image: "assets/images/user.png",
                          name:
                              "${widget.reviews[index].firstName ?? ""} ${widget.reviews[index].lastName ?? ""}",
                          rating: widget.reviews[index].rating ?? 0,
                          date: DateFormat.yMMMMd()
                              .format(widget.reviews[index].createdDate!),
                          description: widget.reviews[index].review ??
                              '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Velit facilisis venenatis amet potenti sed fringilla. Urna mauris vitae, tristique pulvinar convallis arcu et tincidunt. Cursus et id nulla non tellus, id augue. Laoreet bibendum rhoncus mi cras eu sit. Sapien.'''),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 15.h,
                          ),
                      itemCount: widget.reviews.length > 4
                          ? 4
                          : widget.reviews.length))),
        )
      ]),
    );
  }
}
