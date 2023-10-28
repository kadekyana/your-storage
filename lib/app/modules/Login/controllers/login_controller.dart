import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_storage/app/modules/BottomBar/views/bottom_bar_view.dart';

class LoginController extends GetxController {
  Dio dio = Dio();
  //TODO: Implement LoginController
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final String baseurl = 'https://wiwindendriani.000webhostapp.com/api/login';

  List data = [];
  Future<void> login(String email, String password) async {
    try {
      final response =
          await dio.post(baseurl, data: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        print(response.data);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        Future<String> token =
            prefs.setString('Token', response.data['token']) as Future<String>;
        Future<bool> login = prefs.setBool('Login', true);
        data = [
          {
            'Token': prefs.getString('Token'),
            'Login': prefs.getString('Login'),
          }
        ];
        print(token);
        print(login);
        Get.to(BottomBarView());
        Get.snackbar("Berhasil Login", "Selamat Mencoba",
            backgroundColor: Colors.blue, colorText: Colors.white);
      } else {
        Get.snackbar("Error", "Email atau Password Salah");
      }
    } catch (e) {
      print(e);
    }
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
