import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/core/constants/colors.dart';
import 'package:orb/src/features/home/models/hotel_detail.dart';
import 'package:orb/src/features/hotelDetail/widgets/room_card.dart';

class RoomList extends StatelessWidget {
  const RoomList(
      {Key? key,
      this.rooms = const [],
      required this.hotelUri,
      required this.hotel})
      : super(key: key);
  final List<ChooseYourRoom> rooms;
  final HotelDetailModel hotel;
  final String hotelUri;
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
      body: Column(
        children: [
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
                    itemBuilder: (context, index) => RoomCard(
                        hotelUri: hotelUri, room: rooms[index], hotel: hotel),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10.h,
                        ),
                    itemCount: rooms.length),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
