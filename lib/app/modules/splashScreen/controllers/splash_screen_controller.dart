import 'dart:async';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_storage/app/modules/AfterSplash/views/after_splash_view.dart';
import 'package:your_storage/app/modules/BottomBar/views/bottom_bar_view.dart';

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController

  String data = '';

  Future<void> cekLogin() async {
    var duration = Duration(seconds: 3);
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    bool Login = preferences.getBool('Login') ?? false;
    // bool Onboarding = preferences.getBool('Getstart') ?? false;

    if (Login) {
      String? Token = preferences.getString('Token');
      data = Token!;
    }
    return Future.delayed(duration, () {
      if (Login = true) {
        Get.to(BottomBarView());
      } else {
        Get.to(AfterSplashView());
      }
      // if (Onboarding == false) {
      //   Get.to(OnboardingView());
      // } else {
      //   Get.to(
      //     duration: Duration(seconds: 3),
      //     Login ? BottomNavBarView() : AfterSplashView(),
      //   );
      // }
    });
  }

  var duration = const Duration(seconds: 3);

  splashStart() async {
    return Timer(duration, () async {
      Get.to(AfterSplashView());
    });
  }

  // Cek Login Untuk Nanti - Skrng Simpen Aja Dulu -

  // Future<void> cekLogin() async {
  //   var duration = Duration(seconds: 3);
  //   final SharedPreferences preferences = await SharedPreferences.getInstance();
  //   bool Login = preferences.getBool('Login') ?? false;
  //   bool Onboarding = preferences.getBool('Getstart') ?? false;

  //   if (Login) {
  //     String? User_id = preferences.getString('User_id');
  //     String? Nama = preferences.getString('Nama');
  //     String? Saldo = preferences.getString('Saldo');
  //     String? Email = preferences.getString('Email');
  //     String? No_rekening = preferences.getString('No_Rekening');
  //     data = [
  //       {
  //         'user_id': User_id,
  //         'nama': Nama,
  //         'saldo': Saldo,
  //         'email': Email,
  //         'no_rek': No_rekening
  //       }
  //     ];
  //   }
  //   return Future.delayed(duration, () {
  //     if (Onboarding == false) {
  //       Get.to(OnboardingView());
  //     } else {
  //       Get.to(
  //         transition: Transition.fadeIn,
  //         duration: Duration(seconds: 3),
  //         Login ? BottomNavBarView() : AfterSplashView(),
  //       );
  //     }
  //   });
  // }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
