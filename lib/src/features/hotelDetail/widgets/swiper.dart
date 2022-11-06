import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orb/src/core/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SwiperWidget extends StatefulWidget {
  SwiperWidget(
      {Key? key,
      required this.images,
      required this.networkImages,
      required this.bottom,
      required this.height})
      : super(key: key);
  final List<String> images;
  final List<String> networkImages;

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
          children: widget.networkImages.isEmpty
              ? [
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
                ]
              : [
                  ...widget.networkImages.map((e) => Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                "https://astercliqdevstorage.blob.core.windows.net$e",
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
                  itemCount: widget.networkImages.isEmpty
                      ? widget.images.length
                      : widget.networkImages.length,
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
