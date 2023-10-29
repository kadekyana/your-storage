import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_storage/app/modules/BottomBar/views/bottom_bar_view.dart';
import 'package:your_storage/app/modules/Login/views/login_view.dart';

class LoginController extends GetxController {
  Dio dio = Dio();
  //TODO: Implement LoginController
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final String baseurl = 'https://wiwindendriani.000webhostapp.com/api/login';

  List data = [];
  String UserId = '';
  String token = '';
  Future<void> login(String email, String password) async {
    try {
      final response = await dio.post(
        baseurl,
        data: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        print(response.data);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('User_id', response.data['user']['id'].toString());
        prefs.setString('Nama', response.data['user']['name']);
        prefs.setString('Email', response.data['user']['email']);
        prefs.setString('Token', response.data['token']);
        prefs.setBool('Login', true);
        UserId = prefs.getString('User_id')!;
        data = [
          {
            'nama': prefs.getString('Nama'),
            'email': prefs.getString('Email'),
            'userlogin': prefs.getBool('Login'),
            'token': prefs.getString('Token'),
          }
        ];
        print(data);
        print(UserId);
        Get.to(BottomBarView());
        Get.snackbar("Success Login", "Selamat Mencoba",
            backgroundColor: Colors.indigo[900],
            borderColor: Colors.black,
            borderWidth: 1,
            colorText: Colors.white);
      } else {
        Get.snackbar("Error", "Username atau Password Salah");
      }
    } catch (e) {
      Get.snackbar('Erorr', 'Email And Password Salah, Coba Lagi !',
          colorText: Colors.white,
          backgroundColor: Colors.red,
          borderWidth: 1,
          borderColor: Colors.black);
      print(e);
    }
  }

  void logout() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    email.clear();
    password.clear();
    pref.remove('User_id');
    pref.remove('Nama');
    pref.remove('Email');
    pref.remove('Token');
    pref.remove('Login');
    Get.to(LoginView());
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
