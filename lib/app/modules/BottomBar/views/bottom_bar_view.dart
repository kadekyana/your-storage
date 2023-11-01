import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:your_storage/app/modules/Home/views/home_view.dart';
import 'package:your_storage/app/modules/Profile/views/profile_view.dart';

import '../controllers/bottom_bar_controller.dart';

class BottomBarView extends GetView<BottomBarController> {
  BottomBarView({Key? key}) : super(key: key);

  RxInt selectedIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => selectedIndex.value == 0 ? HomeView() : ProfileView()),
      bottomNavigationBar: Obx(
        () => SalomonBottomBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          backgroundColor: Color(0xffC0392B),
          currentIndex: selectedIndex.value,
          onTap: (index) => selectedIndex.value = index,
          items: [
            SalomonBottomBarItem(
              icon: Icon(Icons.home_rounded),
              title: Text('Home'),
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
