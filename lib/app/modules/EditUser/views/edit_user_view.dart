import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:your_storage/app/modules/Login/controllers/login_controller.dart';
import 'package:your_storage/app/modules/Profile/views/profile_view.dart';
import 'package:your_storage/app/modules/splashScreen/controllers/splash_screen_controller.dart';

import '../controllers/edit_user_controller.dart';

class EditUserView extends StatefulWidget {
  const EditUserView({Key? key}) : super(key: key);

  @override
  State<EditUserView> createState() => _EditUserViewState();
}

class _EditUserViewState extends State<EditUserView> {
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  final LoginController login = Get.put(LoginController());
  final SplashScreenController splash = Get.put(SplashScreenController());
  final ImagePicker picker = ImagePicker();
  File? image;
  final _formkey = GlobalKey<FormState>();
  final EditUserController controller = Get.put(EditUserController());
  File? pickImage;

  final TextEditingController namaC = TextEditingController();
  final TextEditingController emailC = TextEditingController();

  @override
  void initState() {
    super.initState();
    namaC.text =
        login.data.isNotEmpty ? login.data[0]['nama'] : splash.data[0]['nama'];
    emailC.text = login.data.isNotEmpty
        ? login.data[0]['email']
        : splash.data[0]['email'];
  }

  @override
  void dispose() {
    namaC.dispose();
    emailC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MQW = MediaQuery.of(context).size.width;
    final MQH = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MQW,
              height: MQH,
              color: Color(0xffC0392B),
            ),
            Positioned(
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
              ),
            ),
            Positioned(
                top: 100,
                left: 10,
                child: Text(
                  'EDIT',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                )),
            Positioned(
              top: 130,
              left: 10,
              child: Text(
                'PROFILE',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MQW,
                height: MQH * 0.65,
                child: Card(
                  elevation: 10,
                  child: Form(
                    key: _formkey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: namaC,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Nama Tidak Boleh Kosong";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                label: Text('Masukkan Nama'),
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.edit)),
                          ),
                          SizedBox(
                            height: MQH * 0.01,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailC,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email Tidak Boleh Kosong";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                label: Text('Masukkan Harga'),
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.sell)),
                          ),
                          SizedBox(
                            height: MQH * 0.01,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GetBuilder<EditUserController>(
                                  builder: (controller) =>
                                      controller.picselect != null
                                          ? Row(
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  child: CircleAvatar(
                                                    radius: 50,
                                                    backgroundImage: FileImage(
                                                        File(controller
                                                            .picselect!.path)),
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () => controller
                                                        .deleteImage(),
                                                    icon: Icon(Icons.delete)),
                                              ],
                                            )
                                          : Text('No Image'),
                                ),
                                TextButton(
                                    onPressed: () => controller.selectImage(),
                                    child: Text('Choose')),
                              ],
                            ),
                          ),
                          Center(
                            child: RoundedLoadingButton(
                              color: Color(0xffC0392B),
                              controller: btnController,
                              onPressed: () {
                                Future.delayed(Duration(seconds: 3), () {
                                  if (_formkey.currentState!.validate()) {
                                    _formkey.currentState!.save();
                                    controller.UpdateUser(namaC.text,
                                        emailC.text, controller.picselect!);
                                  }
                                  btnController.reset();
                                });
                              },
                              child: Text(
                                'EDIT PROFILE',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
