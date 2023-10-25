import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:your_storage/app/modules/Login/views/login_view.dart';

import '../controllers/registrasi_controller.dart';

class RegistrasiView extends GetView<RegistrasiController> {
  RegistrasiView({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();
  final RxBool sembunyikan = false.obs;

  void buttonSembunyikan() {
    sembunyikan.toggle();
  }

  @override
  Widget build(BuildContext context) {
    final MQH = MediaQuery.of(context).size.height;
    final MQW = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: SingleChildScrollView(
            child: Container(
              width: MQW,
              height: MQH,
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        width: MQW * 0.5,
                        height: MQH * 0.25,
                        child: Image(
                          image: AssetImage('images/logo.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MQH * 0.01,
                    ),
                    Container(
                      height: MQH * 0.06,
                      child: FittedBox(
                        child: Text(
                          'YourStorage',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 50),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MQH * 0.01,
                    ),
                    Container(
                      width: MQW * 0.8,
                      height: MQH * 0.45,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            // controller: controller.name,
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
                                suffixIcon: Icon(Icons.verified_user)),
                          ),
                          SizedBox(
                            height: MQH * 0.01,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            // controller: controller.email,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email Tidak Boleh Kosong";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                label: Text('Masukkan Email'),
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.person)),
                          ),
                          SizedBox(
                            height: MQH * 0.01,
                          ),
                          Obx(
                            () => TextFormField(
                              // controller: controller.password,
                              obscureText: !sembunyikan.value,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password Tidak Boleh Kosong";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 20),
                                  label: Text('Masukkan Password'),
                                  border: OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                      onPressed: buttonSembunyikan,
                                      icon: sembunyikan.value
                                          ? Icon(Icons.visibility)
                                          : Icon(Icons.visibility_off))),
                            ),
                          ),
                          SizedBox(
                            height: MQH * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Sudah Punya Akun?',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.to(LoginView());
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color: Color(0xff0E21A0),
                                        fontWeight: FontWeight.w700),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                    Center(
                      child: FilledButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState!.save();
                            //   return controller.register(
                            //       controller.email.text,
                            //       controller.password.text,
                            //       controller.name.text,
                            //       controller.nim.text);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xffC0392B)),
                          padding: MaterialStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                          ),
                        ),
                        child: Text(
                          'Registrasi',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MQH * 0.05,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
