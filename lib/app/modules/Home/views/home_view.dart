import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:your_storage/app/modules/BottomBar/views/bottom_bar_view.dart';
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
  final HomeController home = Get.put(HomeController());
  final LoginController login = Get.put(LoginController());
  final SplashScreenController splash = Get.put(SplashScreenController());

  @override
  void initState() {
    super.initState();
    // UserBarang();
    Future.delayed(Duration(seconds: 5), () {
      setState(() {});
      splash.cekLogin();
      print("login data ${login.data}");
      print("splah data ${splash.data}");
      UserBarang();
    });
  }

  Dio dio = Dio();

  final String baseUrl =
      'https://wiwindendriani.000webhostapp.com/api/userbarang';

  List<dynamic> dataBarang = [];

  Future<void> UserBarang() async {
    final userid = login.data.isNotEmpty
        ? login.data[0]['user_id']
        : splash.data[0]['user_id'];
    final response = await dio.get('$baseUrl/$userid');
    if (response.statusCode == 200) {
      setState(() {});
      dataBarang = response.data['data'];
      print(dataBarang);
    }
  }

  final baseeurl = 'https://wiwindendriani.000webhostapp.com/api/hapus';

  Future<void> hapus(int id) async {
    final response = await dio.post("$baseeurl/$id");
    if (response.statusCode == 200) {
      await UserBarang();
      Get.snackbar("Proses Sukses", "Hapus Barang",
          backgroundColor: Colors.indigo[900],
          borderColor: Colors.black,
          borderWidth: 1,
          colorText: Colors.white);
    } else {
      Get.snackbar("Gagal", "Silahkan Hapus Ulang",
          backgroundColor: Colors.indigo[900],
          borderColor: Colors.black,
          borderWidth: 1,
          colorText: Colors.white);
    }
  }

  final String baseurl = 'https://wiwindendriani.000webhostapp.com/api/detail';
  dynamic barang;

  Future<void> detail(int selectId) async {
    try {
      final response = await dio.get("$baseurl/$selectId");
      if (response.statusCode == 200) {
        print(response.data);
        barang = response.data;
        print("data barang : $barang");
        Get.to(EditBarangView(
          detail: response.data,
        ));
      }
    } catch (e) {
      print(e);
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
                top: 80,
                left: 10,
                child: Text(
                  'YOUR',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                )),
            const Positioned(
              top: 115,
              left: 10,
              child: Text(
                'STORAGE',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
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
                child: dataBarang.isEmpty
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey,
                        highlightColor: Color(0xffC0392B),
                        child: ListView.builder(
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                'Tunggu Sebentar',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700),
                              ),
                              leading: Icon(
                                Icons.image_rounded,
                                size: 30,
                              ),
                              subtitle: Text('Sedang Load Barang',
                                  style: TextStyle(fontFamily: 'Poppins')),
                            );
                          },
                        ),
                      )
                    : ListView.builder(
                        itemCount: dataBarang.length,
                        itemBuilder: (context, index) {
                          final barang = dataBarang[index];
                          return GestureDetector(
                            onTap: () {
                              Get.to(QRCodeView(
                                detail: barang['id'].toString(),
                              ));
                            },
                            child: Slidable(
                              endActionPane: ActionPane(
                                  motion: const DrawerMotion(),
                                  children: [
                                    SlidableAction(
                                      backgroundColor: Colors.blue,
                                      icon: Icons.edit,
                                      label: 'Edit Barang',
                                      onPressed: (context) {
                                        detail(barang['id']);
                                      },
                                    ),
                                    SlidableAction(
                                      backgroundColor: Colors.red,
                                      icon: Icons.delete,
                                      label: 'Hapus Barang',
                                      onPressed: (context) {
                                        hapus(barang['id']);
                                      },
                                    ),
                                  ]),
                              child: Card(
                                child: ListTile(
                                  title: Text(barang['nama']),
                                  leading: barang['gambar'] != null
                                      ? CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            'https://wiwindendriani.000webhostapp.com/${barang['gambar']}',
                                          ),
                                        )
                                      : Icon(Icons.image),
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
