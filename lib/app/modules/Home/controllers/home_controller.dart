import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_storage/app/modules/BottomBar/views/bottom_bar_view.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final baseUrl = 'https://wiwindendriani.000webhostapp.com/api/hapus';

  Future<void> hapus(int id) async {
    final response = await Dio().post("$baseUrl/$id");
    if (response.statusCode == 200) {
      Get.to(BottomBarView());
      Get.snackbar("Proses Sukses", "Hapus Barang",
          backgroundColor: Colors.indigo[900],
          borderColor: Colors.black,
          borderWidth: 1,
          colorText: Colors.white);
    } else {
      Get.snackbar("Gagal", "Silahkan Hapus Ulang",
          backgroundColor: Colors.indigo[900],
          borderColor: Colors.black,
          borderWidth: 1,
          colorText: Colors.white);
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
