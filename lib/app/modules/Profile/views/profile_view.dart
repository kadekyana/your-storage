import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:your_storage/app/modules/Login/controllers/login_controller.dart';
import 'package:your_storage/app/modules/splashScreen/controllers/splash_screen_controller.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final LoginController login = Get.put(LoginController());
  final SplashScreenController splash = Get.put(SplashScreenController());
  @override
  Widget build(BuildContext context) {
    final MQW = MediaQuery.of(context).size.width;
    final MQH = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MQW,
              height: MQH * 0.3,
              decoration: const BoxDecoration(
                color: Color(0xffC0392B),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/default.png'),
                    ),
                  ),
                  Text(
                    '${login.data.isNotEmpty ? login.data[0]['nama'] : splash.data[0]['nama']}',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    '${login.data.isNotEmpty ? login.data[0]['email'] : splash.data[0]['email']}',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MQH * 0.3,
            ),
            FilledButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.indigo[900]),
                padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 10, horizontal: 80),
                ),
              ),
              onPressed: () {
                login.logout();
              },
              child: Text(
                'LOGOUT',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
