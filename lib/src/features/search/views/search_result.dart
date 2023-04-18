import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:orb/src/features/home/controller/hotel_controller.dart';
import 'package:orb/src/features/search/views/explore_filter.dart';
import 'package:orb/src/features/search/widgets/explore_card.dart';

import '../../../core/constants/colors.dart';
import '../../home/controller/search_controller.dart';

class SearchResultPage extends StatelessWidget {
  SearchResultPage({Key? key}) : super(key: key);
  final hotelController = Get.find<HotelController>();
  final searchController = Get.find<SearchController>();
  TextEditingController searchCtrl = TextEditingController();
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
                          color: Color(0xff000000).withOpacity(.15),
                          blurRadius: 10)
                    ],
                    borderRadius: BorderRadius.circular(10.w)),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            FlutterRemix.search_line,
                            color: primaryColor,
                            size: 14.w,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: searchCtrl,
                              textCapitalization: TextCapitalization.none,
                              textAlignVertical: TextAlignVertical.center,
                              style: GoogleFonts.mulish(
                                  color: textPrimary,
                                  fontSize: 16.sp,
                                  height: 1.2),
                              cursorColor: textPrimary,
                              decoration: InputDecoration(
                                counterText: "",

                                border: InputBorder.none,
                                hintText: "Find a hotel...",

                                hintStyle: GoogleFonts.mulish(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: primaryColor.withOpacity(.4),
                                    height: 1.25),

                                isDense: true, // Added this
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 14.h),
                                errorStyle: TextStyle(
                                  inherit: false,
                                  height: 0,
                                  fontSize: 0,
                                ),

                                enabledBorder: InputBorder.none,
                              ),
                              autovalidateMode: AutovalidateMode.disabled,
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).unfocus();
                                hotelController.getSearch(
                                    string: searchCtrl.text,
                                    location: searchCtrl.text,
                                    minPrice:
                                        searchController.roomLowerVal.value,
                                    maxPrice:
                                        searchController.roomUpperVal.value,
                                    checkIn: DateFormat("yyyy/MM/dd").format(
                                        searchController.checkinDate.value),
                                    checkOut: DateFormat("yyyy/MM/dd").format(
                                        searchController.checkOutDate.value),
                                    isSearched: true);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    // IconButton(
                    //     onPressed: () {
                    //       Get.bottomSheet(
                    //         ExploreFilter(),
                    //         barrierColor: primaryColor.withOpacity(.1),
                    //         isDismissible: false,
                    //         isScrollControlled: true,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(50.w),
                    //         ),
                    //         enableDrag: true,
                    //       );
                    //     },
                    //     icon: Icon(
                    //       FlutterRemix.equalizer_line,
                    //       color: primaryColor,
                    //       size: 18.sp,
                    //     ))
                  ],
                ),
              ),
            ),
            Obx(
              () => Expanded(
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                    child: hotelController.search.value.isEmpty
                        ? Center(
                            child: Text("No Result found."),
                          )
                        : ListView.separated(
                            itemBuilder: ((context, index) => ExploreCard(
                                  hotelSearch:
                                      hotelController.search.value[index],
                                )),
                            separatorBuilder: ((context, index) => SizedBox(
                                  height: 10.h,
                                )),
                            itemCount: hotelController.search.value.length,
                          )),
              ),
            )
          ]),
        ),
      ]),
    );
  }
}
