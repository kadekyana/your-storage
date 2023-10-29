import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_storage/app/modules/EditBarang/views/edit_barang_view.dart';
import 'package:your_storage/app/modules/Login/controllers/login_controller.dart';
import 'package:your_storage/app/modules/QRCode/views/q_r_code_view.dart';
import 'package:your_storage/app/modules/Scanner/views/scanner_view.dart';
import 'package:your_storage/app/modules/TambahBarang/views/tambah_barang_view.dart';
import 'package:your_storage/app/modules/splashScreen/controllers/splash_screen_controller.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final LoginController login = Get.put(LoginController());
  final HomeController home = Get.put(HomeController());
  final SplashScreenController splash = Get.put(SplashScreenController());
  final String baseUrl =
      'https://wiwindendriani.000webhostapp.com/api/userbarang';
  Dio dio = Dio();
  List<dynamic> dataBarang = [];

  @override
  void initState() {
    super.initState();
    setState(() {});
    print(login.data);
    print(splash.data);
    Future.delayed(Duration(seconds: 5), () {
      UserBarang();
      splash.cekLogin();
    });
  }

  Future<void> UserBarang() async {
    final userid = login.data.isNotEmpty
        ? login.data[0]['user_id']
        : splash.data[0]['user_id'];
    final response = await dio.get('$baseUrl/$userid');
    if (response.statusCode == 200) {
      setState(() {
        dataBarang = response.data['data'];
        print(dataBarang);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final MQW = MediaQuery.of(context).size.width;
    final MQH = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[900],
        onPressed: () {
          Get.to(TambahBarangView());
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: MQW,
              height: MQH,
            ),
            const Positioned(
                top: 30,
                left: 10,
                child: Text(
                  'YOUR',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                )),
            const Positioned(
              top: 50,
              left: 10,
              child: Text(
                'STORAGE',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Positioned(
              top: 90,
              left: 10,
              child: Form(
                child: Container(
                  width: MQW * 0.7,
                  height: MQH * 0.07,
                  child: TextFormField(
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search),
                        label: Text('Search'),
                        border: OutlineInputBorder()),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 90,
              left: 290,
              child: GestureDetector(
                onTap: () {
                  Get.to(ScannerView());
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.qr_code_rounded),
                    ),
                    Text(
                      'Scanner',
                      style: TextStyle(
                          fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 160,
              child: Container(
                width: MQW,
                height: MQH * 0.7,
                child: ListView.builder(
                  itemCount: dataBarang.length,
                  itemBuilder: (context, index) {
                    final barang = dataBarang[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(QRCodeView());
                      },
                      child: Slidable(
                        endActionPane:
                            ActionPane(motion: const DrawerMotion(), children: [
                          SlidableAction(
                              backgroundColor: Colors.blue,
                              icon: Icons.edit,
                              label: 'Edit Barang',
                              onPressed: (context) {
                                Get.to(EditBarangView());
                              }),
                          SlidableAction(
                              backgroundColor: Colors.red,
                              icon: Icons.delete,
                              label: 'Hapus Barang',
                              onPressed: (context) {})
                        ]),
                        child: Card(
                          child: ListTile(
                            title: Text(barang['nama']),
                            leading: Image.asset('images/wi.png'),
                            subtitle: Text(barang['tanggal'],
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
