import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_storage/app/modules/Login/views/login_view.dart';

class RegistrasiController extends GetxController {
  Dio dio = Dio();
  //TODO: Implement RegistrasiController
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final String baseUrl =
      'https://wiwindendriani.000webhostapp.com/api/register';
  //

  Future<void> registrasi(String nama, String email, String password) async {
    try {
      final response = await dio.post(baseUrl,
          data: {'name': nama, 'email': email, 'password': password});
      if (response.statusCode == 201) {
        print(response.data);
        Get.to(LoginView());
        Get.snackbar(
          'Berhasil Registrasi',
          'Silahkan Login',
          colorText: Colors.white,
          backgroundColor: Colors.blue,
        );
      } else {
        Get.snackbar(
          'Gagal Registrasi',
          'Silahkan Coba Lagi dan Cek Koneksi',
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
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
