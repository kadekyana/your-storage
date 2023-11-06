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

class EditBarangController extends GetxController {
  //TODO: Implement EditBarangController
  final LoginController login = Get.put(LoginController());
  final SplashScreenController splash = Get.put(SplashScreenController());

  final String baseurl = 'https://wiwindendriani.000webhostapp.com/api/update';
  Dio dio = Dio();

  Future<void> updateBarang(String nama, String warna, String jumlah,
      String harga, String tanggal, int barang, File image) async {
    int kategoriId = selectedValueDrop == "Elektronik" ? 1 : 2;
    final userid = login.data.isNotEmpty
        ? login.data[0]['user_id']
        : splash.data[0]['user_id'];

    print(userid);
    if (image != null) {
      print('cek setelah dalam fuction : ${image.path}');
      try {
        FormData formData = FormData.fromMap({
          'user_id': userid,
          'kategori_id': kategoriId,
          'nama': nama,
          'warna': warna,
          'jumlah': jumlah,
          'tanggal': tanggal,
          'harga': harga,
          'gambar': await dioo.MultipartFile.fromFileSync(image.path,
              filename: 'image.jpg')
        });

        final dio = Dio();
        final response = await dio.post(
          '$baseurl/$barang',
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

  // void updateBarang(String nama, String warna, String jumlah, String harga,
  //     String tanggal, int barang, File image) async {
  //   try {
  //     final userid = login.data.isNotEmpty
  //         ? login.data[0]['user_id']
  //         : splash.data[0]['user_id'];
  //     int kategoriId = selectedValueDrop == "Elektronik" ? 1 : 2;
  //     final response = await dio.post("$baseurl/$barang", data: {
  //       "user_id": userid,
  //       "kategori_id": kategoriId,
  //       "nama": nama,
  //       "warna": warna,
  //       "jumlah": jumlah,
  //       "harga": harga,
  //       "tanggal": tanggal,
  //       "gambar": await dioo.MultipartFile.fromFileSync(image.path,
  //           filename: 'image')
  //     });
  //     if (response.statusCode == 200) {
  //       print(response.data);
  //       Get.to(BottomBarView());
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  final ImagePicker picker = ImagePicker();
  File? picselect;

  void selectImage() async {
    try {
      final select = await picker.pickImage(source: ImageSource.gallery);

      if (select != null) {
        print(select.name);
        print(select.path);
        picselect = File(select.path);
        update();
        print(picselect);
        print('pickselect ${picselect?.path}');
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
