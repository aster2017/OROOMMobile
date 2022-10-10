import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/features/home/controller/hotel_controller.dart';
import 'package:orb/src/features/search/views/explore_filter.dart';
import 'package:orb/src/features/search/widgets/explore_card.dart';

import '../../../core/constants/colors.dart';

class SearchResultPage extends StatelessWidget {
  SearchResultPage({Key? key}) : super(key: key);
  final hotelController = Get.find<HotelController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: textPrimary),
        title: Text(
          "Search Result",
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Container(
                height: 50.w,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xff00A5F4).withOpacity(.25),
                          blurRadius: 10)
                    ],
                    borderRadius: BorderRadius.circular(10.w)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          FlutterRemix.search_line,
                          color: primaryColor,
                          size: 14.w,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          "Find a hotel...",
                          style: GoogleFonts.mulish(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: primaryColor.withOpacity(.4),
                              height: 1.25),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          Get.bottomSheet(
                            ExploreFilter(),
                            barrierColor: primaryColor.withOpacity(.1),
                            isDismissible: false,
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.w),
                            ),
                            enableDrag: true,
                          );
                        },
                        icon: Icon(
                          FlutterRemix.equalizer_line,
                          color: primaryColor,
                          size: 18.sp,
                        ))
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                  child: ListView.separated(
                    itemBuilder: ((context, index) => ExploreCard(
                          hotelSearch: hotelController.search.value[index],
                        )),
                    separatorBuilder: ((context, index) => SizedBox(
                          height: 10.h,
                        )),
                    itemCount: hotelController.search.value.length,
                  )),
            )
          ]),
        ),
      ]),
    );
  }
}
