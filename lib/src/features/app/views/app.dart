import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orb/src/features/app/widget/bottomNav.dart';
import 'package:orb/src/features/home/views/home.dart';
import '../../../core/controller/auth_controller.dart';
import '../../account/controller/myBooking.dart';
import '../../account/views/account.dart';
import '../../booking/controller/bookingController.dart';
import '../../home/controller/search_controller.dart';
import '../../search/views/expolre_page.dart';
import '../controller/bottom_nav.dart';

class AppPage extends StatelessWidget {
  AppPage({Key? key}) : super(key: key);

  final BottomNavController bottomNavController =
      Get.find<BottomNavController>();
  final SearchController searchController = Get.put(SearchController());
  final MyBookingController myBookingController =
      Get.put(MyBookingController());
  final AuthController authController = Get.put(AuthController());
  final BookingController bookingController = Get.put(BookingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (bottomNavController.currentIndex.value) {
          case 0:
            return HomePage();
          case 1:
            return ExplorePage();
          case 2:
            return AccountPage();
          default:
            return HomePage();
        }
      }),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
