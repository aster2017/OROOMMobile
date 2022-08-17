import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/core/constants/colors.dart';
import 'package:orb/src/features/hotelDetail/widgets/room_card.dart';

class RoomList extends StatelessWidget {
  const RoomList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: textPrimary),
        title: Text(
          "Choose Room",
          style: GoogleFonts.mulish(
              color: textPrimary, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: ListView.separated(
            itemBuilder: (context, index) => RoomCard(),
            separatorBuilder: (context, index) => SizedBox(
                  height: 10.h,
                ),
            itemCount: 6),
      ),
    );
  }
}
