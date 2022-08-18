import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/features/hotelDetail/widgets/review_card.dart';

import '../../../core/constants/colors.dart';

class ReviewAllPage extends StatefulWidget {
  const ReviewAllPage({Key? key}) : super(key: key);

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
                    shrinkWrap: true,
                    itemBuilder: ((context, index) => ReviewCard(
                        image: "assets/images/user.png",
                        name: "Amrit Acharya",
                        rating: 4,
                        date: "15 Apr, 2022",
                        description:
                            '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Velit facilisis venenatis amet potenti sed fringilla. Urna mauris vitae, tristique pulvinar convallis arcu et tincidunt. Cursus et id nulla non tellus, id augue. Laoreet bibendum rhoncus mi cras eu sit. Sapien.''')),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10.h,
                        ),
                    itemCount: 12)),
          ),
        )
      ]),
    );
  }
}
