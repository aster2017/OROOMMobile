import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/core/authentication_manager.dart';
import 'package:orb/src/core/ui/textfield.dart';
import 'package:orb/src/features/hotelDetail/views/hotel_detail.dart';

import '../../../core/constants/colors.dart';

class PostReview extends StatefulWidget {
  const PostReview({
    Key? key,
    required this.reviewAdd,
    required this.hotelUri,
    required this.addReview,
  }) : super(key: key);
  final String hotelUri;
  final bool addReview;
  final void Function() reviewAdd;
  @override
  State<PostReview> createState() => _PostReviewState();
}

class _PostReviewState extends State<PostReview> {
  bool showAll = false;
  double rating = 0;
  TextEditingController textEditingController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthenticationManager authenticationManager =
      Get.find<AuthenticationManager>();
  @override
  void initState() {
    super.initState();
    showAll = widget.addReview;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => authenticationManager.isLogged.value
          ? Container(
              decoration: BoxDecoration(
                  border: Border.symmetric(
                      horizontal: BorderSide(color: Color(0xffF2F2F2)))),
              margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 20.w),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showAll = !showAll;
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
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
                        Expanded(
                            child: Container(
                          color: Colors.transparent,
                        )),
                        Icon(showAll
                            ? FlutterRemix.arrow_drop_down_line
                            : FlutterRemix.arrow_drop_right_line)
                      ],
                    ),
                  ),
                  showAll
                      ? Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 12.w),
                          margin: EdgeInsets.only(top: 12.h),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.w),
                                decoration: BoxDecoration(
                                    border: Border.all(color: greyColor),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Column(
                                  children: [
                                    Text(
                                      "Your overall rating of this hotel.",
                                      style: GoogleFonts.mulish(
                                          fontSize: 12.sp,
                                          color: textPrimary,
                                          fontWeight: FontWeight.w500,
                                          height: 1.25),
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    RatingBar.builder(
                                      ignoreGestures: false,
                                      itemSize: 20.sp,
                                      initialRating: rating,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      unratedColor: greyColor,
                                      itemCount: 5,
                                      itemPadding: EdgeInsets.only(right: 1),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (val) {
                                        setState(() {
                                          rating = val;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Form(
                                key: formKey,
                                child: KTextFormField(
                                  autofocus: widget.addReview,
                                  controller: textEditingController,
                                  label: "",
                                  hint: "What did you like or dislike?",
                                  isFilled: true,
                                  validator: ((p0) {
                                    return p0 == null || p0.isEmpty
                                        ? "Enter a review"
                                        : null;
                                  }),
                                  maxLines: 5,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      textEditingController.clear();
                                      setState(() {
                                        rating = 0;
                                        showAll = false;
                                      });
                                      FocusScope.of(context).unfocus();
                                    },
                                    child: Container(
                                      width: 150.w,
                                      height: 38.h,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(22.h),
                                          color: primaryColor.withOpacity(.1)),
                                      child: Center(
                                        child: Text(
                                          "Cancel",
                                          style: GoogleFonts.mulish(
                                              color: primaryColor,
                                              height: 1.4,
                                              fontSize: 16.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (!formKey.currentState!.validate() ||
                                          rating == 0) {
                                        return;
                                      }
                                      try {
                                        await hotelController.postReviewData(
                                            hotelUri: widget.hotelUri,
                                            rating: rating.toInt(),
                                            review: textEditingController.text);
                                        widget.reviewAdd.call();
                                      } catch (e) {
                                        print(e.toString());
                                      }
                                    },
                                    child: Container(
                                      width: 150.w,
                                      height: 38.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(22.h),
                                          color: primaryColor),
                                      child: Center(
                                        child: Text(
                                          "Submit",
                                          style: GoogleFonts.mulish(
                                              color: whiteColor,
                                              height: 1.4,
                                              fontSize: 16.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ))
                      : Container()
                ],
              ),
            )
          : Container(),
    );
  }
}
