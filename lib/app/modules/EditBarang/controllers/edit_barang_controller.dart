import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_storage/app/modules/BottomBar/views/bottom_bar_view.dart';
import 'package:your_storage/app/modules/Login/controllers/login_controller.dart';
import 'package:your_storage/app/modules/splashScreen/controllers/splash_screen_controller.dart';
import 'package:your_storage/app/widget/custom_dropdown_button.dart';

class EditBarangController extends GetxController {
  //TODO: Implement EditBarangController
  final LoginController login = Get.put(LoginController());
  final SplashScreenController splash = Get.put(SplashScreenController());

  final String baseurl = 'https://wiwindendriani.000webhostapp.com/api/update';
  Dio dio = Dio();

  void updateBarang(String nama, String warna, String jumlah, String harga,
      String tanggal, int barang) async {
    try {
      final userid = login.data.isNotEmpty
          ? login.data[0]['user_id']
          : splash.data[0]['user_id'];
      int kategoriId = selectedValueDrop == "Elektronik" ? 1 : 2;
      final response = await dio.post("$baseurl/$barang", data: {
        "user_id": userid,
        "kategori_id": kategoriId,
        "nama": nama,
        "warna": warna,
        "jumlah": jumlah,
        "harga": harga,
        "tanggal": tanggal
      });
      if (response.statusCode == 200) {
        print(response.data);
        Get.to(BottomBarView());
      }
    } catch (e) {
      print(e);
    }
  }

  String selectedValueDrop = 'Elektronik';

  void selectDropdown(value) {
    selectedValueDrop = value;
    update();
  }

  Column dropdownForm(
      {required List<String> items,
      required void Function(String) changeValue,
      required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        CustomDropdownButton(
            icon:
                const Icon(Icons.keyboard_arrow_down, color: Color(0xFF8F9098)),
            width: double.maxFinite,
            value: value,
            backgroundColor: Colors.white,
            changeValue: changeValue,
            items: items),
      ],
    );
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
