import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:orb/src/features/home/widgets/hotel_card.dart';
import 'package:orb/src/features/home/widgets/popular_card.dart';

import '../controller/hotel_controller.dart';
import '../models/hotel.dart';

class PopularSection extends StatefulWidget {
  const PopularSection({super.key});

  @override
  State<PopularSection> createState() => _PopularSectionState();
}

class _PopularSectionState extends State<PopularSection> {
  final HotelController hotelController = Get.find<HotelController>();
  final PageController ctrl =
      PageController(viewportFraction: 0.5, initialPage: 1);

  int currentPage = 1;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PageView.builder(
          controller: ctrl,
          itemCount: hotelController.popular.value.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, int index) {
            // Active page
            bool active = index == currentPage;
            return _buildStoryPage(active, index,
                hotel: hotelController.popular.value[index]);
          }),
    );
  }

  @override
  void initState() {
    super.initState();
    ctrl.addListener(() {
      int pos = ctrl.page!.round();
      if (currentPage != pos) {
        {
          setState(() {
            currentPage = pos;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  _buildStoryPage(bool active, int index, {Hotel? hotel}) {
    // print("$index, $currentPage");
    return AnimatedScale(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        scale: active ? 1.1 : .9,
        child: Stack(
          alignment: Alignment.center,
          children: [
            PopularHotelCard(hotel: hotel!),
            active
                ? Container()
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10.w),
                    child: BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: active ? 0 : 2, sigmaY: active ? 0 : 2),
                        child: Container(
                            width: 175.w,
                            margin: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                color: Colors.white.withOpacity(.2)))),
                  ),
          ],
        ));
  }
}
