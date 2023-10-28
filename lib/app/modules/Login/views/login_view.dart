import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:your_storage/app/modules/BottomBar/views/bottom_bar_view.dart';
import 'package:your_storage/app/modules/Registrasi/views/registrasi_view.dart';

import '../controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController controller = Get.put(LoginController());

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
          padding: const EdgeInsets.only(bottom: 30),
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
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
                      height: MQH * 0.03,
                    ),
                    Container(
                      width: MQW * 0.8,
                      height: MQH * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: controller.email,
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
                              controller: controller.password,
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
                          SizedBox(
                            height: MQH * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Belum Punya Akun?',
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 12),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.to(RegistrasiView());
                                  },
                                  child: Text(
                                    'Registrasi',
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
                            Get.to(BottomBarView());
                            controller.login(controller.email.text,
                                controller.password.text);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xffC0392B)),
                          padding: MaterialStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 10, horizontal: 80),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700),
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
    );
  }
}
