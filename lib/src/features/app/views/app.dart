import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orb/src/features/app/widget/bottomNav.dart';
import 'package:orb/src/features/home/views/home.dart';
import 'package:orb/src/features/wishlist/views/wishlist.dart';
import '../../account/views/account.dart';
import '../../search/views/expolre_page.dart';
import '../controller/bottom_nav.dart';

class AppPage extends StatelessWidget {
  AppPage({Key? key}) : super(key: key);

  final BottomNavController bottomNavController =
      Get.find<BottomNavController>();
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
            return WishlistPage();
          case 3:
            return AccountPage();
          default:
            return HomePage();
        }
      }),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
