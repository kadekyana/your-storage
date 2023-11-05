import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_storage/app/modules/AfterSplash/views/after_splash_view.dart';

class OnBoardingController extends GetxController {
  //TODO: Implement OnBoardingController

  void Getstart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('Getstart', true);
    Get.to(AfterSplashView());
  }

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
