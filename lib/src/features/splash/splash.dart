import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/core/authentication_manager.dart';
import 'package:orb/src/core/constants/colors.dart';
import 'package:orb/src/core/controller/auth_controller.dart';
import 'package:orb/src/features/app/controller/bottom_nav.dart';
import 'package:orb/src/features/app/views/app.dart';
import 'package:orb/src/features/home/controller/hotel_controller.dart';
import 'package:orb/src/features/onBoarding/onBoard.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final BottomNavController bottomNavController =
      Get.put(BottomNavController());
  final AuthController authController = Get.find<AuthController>();
  final AuthenticationManager authenticationManager =
      Get.find<AuthenticationManager>();
  final HotelController hotelController = Get.find<HotelController>();
  @override
  void initState() {
    super.initState();
    fetchHomeData();
  }

  fetchHomeData() async {
    await hotelController.getFeatured();
    await hotelController.getPopular();
    checkInitial();
  }

  checkInitial() {
    GetStorage box = GetStorage();
    if (box.read('seen') == null || box.read('seen') == false) {
      Future.delayed(Duration(seconds: 1), () {
        Get.offAll(OnBoardingPage());
      });
    } else {
      Future.delayed(Duration(seconds: 1), () {
        authenticationManager.checkLoginStatus();
        Get.offAll(AppPage());
      });
    }
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
