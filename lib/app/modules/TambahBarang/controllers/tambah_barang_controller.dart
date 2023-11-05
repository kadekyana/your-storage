import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:image_picker/image_picker.dart';
import 'package:your_storage/app/modules/BottomBar/views/bottom_bar_view.dart';
import 'package:your_storage/app/modules/Login/controllers/login_controller.dart';
import 'package:your_storage/app/modules/splashScreen/controllers/splash_screen_controller.dart';
import 'package:your_storage/app/widget/custom_dropdown_button.dart';

class TambahBarangController extends GetxController {
  final LoginController login = Get.put(LoginController());
  final SplashScreenController splash = Get.put(SplashScreenController());

  final TextEditingController nama = TextEditingController();
  final TextEditingController tanggal = TextEditingController();
  final TextEditingController jumlah = TextEditingController();
  final TextEditingController warna = TextEditingController();
  final TextEditingController harga = TextEditingController();
  final String baseurl = 'https://wiwindendriani.000webhostapp.com/api/tambah';
  Dio dio = Dio();
  String selectedValueDrop = 'Elektronik';

  void selectDropdown(value) {
    selectedValueDrop = value;
    update();
  }

  void clearForm() {
    nama.clear();
    jumlah.clear();
    harga.clear();
    warna.clear();
    tanggal.clear();
  }

  final ImagePicker picker = ImagePicker();
  XFile? picselect;

  void selectImage() async {
    try {
      final select = await picker.pickImage(source: ImageSource.camera);

      if (select != null) {
        print(select.name);
        print(select.path);
        picselect = select;
        update();
      }
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

    print(userid);
    if (picselect != null) {
      print(picselect!.path);
      try {
        FormData formData = FormData.fromMap({
          'user_id': userid,
          'kategori_id': kategoriId,
          'nama': nama,
          'warna': warna,
          'jumlah': jumlah,
          'tanggal': tanggal,
          'harga': harga,
          'image': dioo.MultipartFile.fromFile(picselect!.path,
              filename: 'image.png'),
        });

        final response = await dio.post(
          baseurl,
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'multipart/form-data',
            },
          ),
        );

        if (response.statusCode == 200) {
          print('Success');
          print(response.data);
          Get.to(BottomBarView());
          dispose();
          Get.snackbar("Sukses", "Tambah Barang",
              backgroundColor: Colors.indigo[900],
              borderColor: Colors.black,
              borderWidth: 1,
              colorText: Colors.white);
          return response.data;
        } else {
          print('Gagal');
        }
      } catch (e) {
        print('Kesalahan: $e');
      }
    }
  }

  // Future<void> tambah(String nama, String warna, String jumlah, String harga,
  //     String tanggal) async {
  //   int kategoriId = selectedValueDrop == "Elektronik" ? 1 : 2;
  //   final userid = login.data.isNotEmpty
  //       ? login.data[0]['user_id']
  //       : splash.data[0]['user_id'];
  //   try {
  //     FormData formData = FormData.fromMap({
  //       'user_id': userid,
  //       'kategori_id': kategoriId,
  //       'nama': nama,
  //       'warna': warna,
  //       'jumlah': jumlah,
  //       'tanggal': tanggal,
  //       'harga': harga,
  //     });

  //     final response = await dio.post(baseurl, data: formData);
  //     if (response.statusCode == 200) {
  //       print('Success');
  //       print(response.data);
  //       return response.data;
  //     } else {
  //       print('Gagal');
  //     }
  //   } catch (e) {
  //     print('Kesalahan: $e');
  //   }
  // }

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

  // void increment() => count.value++;
}
