import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/colors.dart';

class FilterList extends StatefulWidget {
  const FilterList({Key? key, required this.label, required this.options})
      : super(key: key);
  final String label;
  final List<String> options;
  @override
  State<FilterList> createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  List<String> selectedOption = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Price Range",
          textAlign: TextAlign.left,
          style: GoogleFonts.mulish(
              color: textPrimary,
              height: 1.4,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 6.h,
        ),
        SizedBox(
          height: 30.h,
          child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedOption
                                .contains(widget.options[index])) {
                              selectedOption.remove(widget.options[index]);
                            } else {
                              selectedOption.add(widget.options[index]);
                            }
                          });
                        },
                        child: Container(
                          constraints: BoxConstraints(minWidth: 100.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          decoration: BoxDecoration(
                              border: Border.all(color: secondaryColor),
                              borderRadius: BorderRadius.circular(16.w),
                              color:
                                  selectedOption.contains(widget.options[index])
                                      ? secondaryColor
                                      : Colors.transparent),
                          child: Center(
                            child: Text(
                              widget.options[index],
                              style: GoogleFonts.mulish(
                                  color: selectedOption
                                          .contains(widget.options[index])
                                      ? Colors.white
                                      : textPrimary,
                                  height: 1.4,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                  separatorBuilder: (context, index) => SizedBox(
                        width: 6.w,
                      ),
                  itemCount: widget.options.length)),
        )
      ],
    );
  }
}
