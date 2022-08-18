import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orb/src/core/constants/colors.dart';

class SwiperWidget extends StatefulWidget {
  SwiperWidget(
      {Key? key,
      required this.images,
      required this.bottom,
      required this.height})
      : super(key: key);
  final List<String> images;

  final double bottom, height;

  @override
  State<SwiperWidget> createState() => _SwiperWidgetState();
}

class _SwiperWidgetState extends State<SwiperWidget> {
  PageController pageController = PageController(initialPage: 0);

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PageView(
          controller: pageController,
          onPageChanged: (value) => setState(() {
            currentIndex = value;
          }),
          children: [
            ...widget.images.map((e) => Stack(
                  children: [
                    Image.asset(
                      e,
                      fit: BoxFit.cover,
                      height: widget.height.h,
                      width: double.infinity,
                    ),
                    Container(
                      color: Color(0xff000000).withOpacity(.20),
                    )
                  ],
                ))
          ],
        ),
        Positioned(
          bottom: widget.bottom,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 6.h,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return index == currentIndex
                        ? Container(
                            width: 6.w,
                            height: 6.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.white),
                          )
                        : Container(
                            width: 6.w,
                            height: 6.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: whiteColor)),
                          );
                  },
                  itemCount: widget.images.length,
                  separatorBuilder: (context, index) => SizedBox(
                    width: 4.w,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
