import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/core/constants/colors.dart';
import 'package:orb/src/features/app/controller/bottom_nav.dart';
import 'package:orb/src/features/app/views/app.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final BottomNavController bottomNavController =
      Get.put(BottomNavController());
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Get.offAll(AppPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: primaryColor),
        child: Center(
          child: Text(
            "LOGO HERE",
            style: GoogleFonts.mulish(color: whiteColor),
          ),
        ),
      ),
    );
  }
}
