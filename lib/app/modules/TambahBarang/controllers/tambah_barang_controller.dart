import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:your_storage/app/modules/BottomBar/views/bottom_bar_view.dart';
import 'package:your_storage/app/modules/Login/controllers/login_controller.dart';
import 'package:your_storage/app/modules/splashScreen/controllers/splash_screen_controller.dart';
import 'package:your_storage/app/widget/custom_dropdown_button.dart';

class TambahBarangController extends GetxController {
  //TODO: Implement TambahBarangController
  final LoginController login = Get.put(LoginController());
  final SplashScreenController splash = Get.put(SplashScreenController());
  final TextEditingController nama = TextEditingController();
  final TextEditingController tanggal = TextEditingController();
  final TextEditingController jumlah = TextEditingController();
  final TextEditingController warna = TextEditingController();
  final TextEditingController harga = TextEditingController();
  final String baseurl = 'https://wiwindendriani.000webhostapp.com/api/tambah';

  ImagePicker picker = ImagePicker();
  String selectedValueDrop = '';
  XFile? picselect = null;

  void selectDropdown(value) {
    selectedValueDrop = value;
    update();
  }

  void selectImage() async {
    try {
      final select = await picker.pickImage(source: ImageSource.gallery);

      if (select != null) {
        print(select.name);
        print(select.path);
        picselect = select;
      }
      update();
    } catch (err) {
      print(err);
      picselect = null;
      update();
    }
  }

  void deleteImage() {
    picselect = null;
    update();
  }

  Future<void> tambah(String nama, String warna, String jumlah, String harga,
      String tanggal) async {
    int kategoriId = selectedValueDrop == "Elektronik" ? 1 : 2;
    final userid = login.data.isNotEmpty
        ? login.data[0]['user_id']
        : splash.data[0]['user_id'];
    List<int> imageBytes = File(picselect!.path).readAsBytesSync();
    try {
      final response = await dio.Dio().post(
        'https://wiwindendriani.000webhostapp.com/api/tambah',
        data: {
          'user_id': userid,
          'kategori_id': kategoriId,
          'nama': nama,
          'warna': warna,
          'jumlah': jumlah,
          'harga': harga,
          'tanggal': tanggal,
          'gambar': dio.MultipartFile.fromBytes(imageBytes),
        },
        options: dio.Options(headers: {
          'Content-Type': 'multipart/form-data',
        }, followRedirects: true, maxRedirects: 6),
      );

      if (response.statusCode == 200) {
        Get.to(BottomBarView());
        print(response.data);
      } else {
        print('Gagal menambahkan barang');
      }
    } catch (e) {
      print(e);
    }
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

  // final count = 0.obs;
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  // void increment() => count.value++;
}
