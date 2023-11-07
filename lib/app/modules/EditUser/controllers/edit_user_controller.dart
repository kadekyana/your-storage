import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:image_picker/image_picker.dart';
import 'package:your_storage/app/modules/BottomBar/views/bottom_bar_view.dart';
import 'package:your_storage/app/modules/Login/controllers/login_controller.dart';
import 'package:your_storage/app/modules/Login/views/login_view.dart';
import 'package:your_storage/app/modules/Profile/views/profile_view.dart';
import 'package:your_storage/app/modules/splashScreen/controllers/splash_screen_controller.dart';

class EditUserController extends GetxController {
  final LoginController login = Get.put(LoginController());
  final SplashScreenController splash = Get.put(SplashScreenController());

  final String baseurl =
      'https://wiwindendriani.000webhostapp.com/api/updateUser';
  Dio dio = Dio();

  Future<void> UpdateUser(String nama, String email, File image) async {
    final userid = login.data.isNotEmpty
        ? login.data[0]['user_id']
        : splash.data[0]['user_id'];

    print(userid);
    if (image != null) {
      print('cek setelah dalam fuction : ${image.path}');
      try {
        FormData formData = FormData.fromMap({
          'email': email,
          'name': nama,
          'gambar': await dioo.MultipartFile.fromFileSync(image.path,
              filename: 'image.jpg')
        });

        final dio = Dio();
        final response = await dio.post(
          '$baseurl/$userid',
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
          Future.delayed(Duration(seconds: 3), () {
            login.logout();
            Get.to(LoginView());
            Get.snackbar("Sukses Edit Profile", "Silahkan Login Kembali",
                backgroundColor: Colors.indigo[900],
                borderColor: Colors.black,
                borderWidth: 1,
                colorText: Colors.white);
            return response.data;
          });
        } else {
          print('Gagal');
        }
      } catch (e) {
        print('Kesalahan: $e');
      }
    }
  }

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
