import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:your_storage/app/modules/Login/views/login_view.dart';
import 'package:your_storage/app/modules/Registrasi/views/registrasi_view.dart';

import '../controllers/after_splash_controller.dart';

class AfterSplashView extends GetView<AfterSplashController> {
  const AfterSplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Image.asset('images/logo.png')),
                    Text(
                      'YourStorage',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 25),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      'Inventarisasi Cepat',
                      style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                    ),
                    Text(
                      '-Pengelolaan Mudah-',
                      style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xffC0392B)),
                        padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 15, horizontal: 75),
                        ),
                      ),
                      onPressed: () {
                        Get.to(LoginView());
                      },
                      child: Text(
                        'MASUK',
                        style: TextStyle(
                            fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    FilledButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xffC0392B)),
                        padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                        ),
                      ),
                      onPressed: () {
                        Get.to(RegistrasiView());
                      },
                      child: Text(
                        'REGISTRASI',
                        style: TextStyle(
                            fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
