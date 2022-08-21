import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/colors.dart';
import '../widgets/profile_menu.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: textPrimary),
        title: Text(
          "Settings",
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ProfileMenu(
                title: "Security",
                onTap: () {},
              ),
              SizedBox(
                height: 6.h,
              ),
              ProfileMenu(
                title: "Contact Us",
                onTap: () {},
              ),
              SizedBox(
                height: 6.h,
              ),
              ProfileMenu(
                title: "Terms of Service",
                onTap: () {},
              ),
              SizedBox(
                height: 6.h,
              ),
              ProfileMenu(
                onTap: () {},
                title: "Privacy Policy",
              ),
              SizedBox(
                height: 6.h,
              ),
              ProfileMenu(
                onTap: () {},
                title: "Give Us feedback",
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
