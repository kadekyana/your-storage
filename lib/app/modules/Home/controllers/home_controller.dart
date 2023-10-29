import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_storage/app/modules/Login/controllers/login_controller.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final LoginController login = Get.put(LoginController());
  Dio dio = Dio();

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
