import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:your_storage/app/modules/BottomBar/views/bottom_bar_view.dart';

class DetailBarangView extends StatefulWidget {
  String qrResult;
  DetailBarangView({Key? key, required this.qrResult}) : super(key: key);

  @override
  State<DetailBarangView> createState() => _DetailBarangViewState();
}

class _DetailBarangViewState extends State<DetailBarangView> {
  final String baseurl = 'https://wiwindendriani.000webhostapp.com/api/detail';

  dynamic barang = [];
  Dio dio = Dio();
  Future<void> detail(String qrResult) async {
    try {
      final response = await dio.get("$baseurl/$qrResult");
      if (response.statusCode == 200) {
        print(response.data);
        setState(() {
          barang = response.data;
        });
        print("data barang : $barang");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      detail(widget.qrResult);
    });
  }

  @override
  void dispose() {
    barang.dispose;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.qrResult);
    final MQW = MediaQuery.of(context).size.width;
    final MQH = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: barang.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitCircle(
                    color: Color(0xffC0392B),
                    size: 80,
                  ),
                  SizedBox(
                    height: MQH * 0.01,
                  ),
                  Text(
                    'Tunggu Sebentar',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  )
                ],
              )
            : Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: MQW,
                    height: MQH,
                    color: Colors.white,
                  ),
                  Positioned(
                    child: Container(
                        width: MQW,
                        height: MQH * 0.25,
                        child: Image(
                          image: NetworkImage(
                              'https://wiwindendriani.000webhostapp.com/${barang['data']['gambar']}'),
                          fit: BoxFit.fitWidth,
                        )),
                  ),
                  Positioned(
                    child: IconButton(
                      onPressed: () {
                        barang.clear();
                        widget.qrResult = '';
                        print(widget.qrResult);
                        print(barang);
                        Get.to(BottomBarView());
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                  ),
                  Positioned(
                    top: 160,
                    left: 35,
                    child: Container(
                      width: MQW * 0.8,
                      height: MQH * 0.1,
                      child: Card(
                        elevation: 10,
                        child: Center(
                          child: Text(
                            "${barang['data']['nama']}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 30,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: MQW,
                      height: MQH * 0.6,
                      child: Card(
                        color: Color(0xffC0392B),
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                width: MQW,
                                height: MQH * 0.1,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'Detail',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 25,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      'Barang',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: Colors.white,
                                thickness: 2,
                              ),
                              SizedBox(
                                height: MQH * 0.03,
                              ),
                              Card(
                                elevation: 10,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        'Jenis Barang',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        '${barang['data']['kategori_id'] == 1 ? 'Elektronik' : 'Non Elektronik'}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: MQH * 0.01,
                                      ),
                                      Text(
                                        'Tanggal Barang di Tambah',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        '${barang['data']['tanggal']}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: MQH * 0.01,
                                      ),
                                      Text(
                                        'Harga Barang',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        'Rp ${barang['data']['harga']}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: MQH * 0.01,
                                      ),
                                      Text(
                                        'Warna Barang',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        '${barang['data']['warna']}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: MQH * 0.01,
                                      ),
                                      Text(
                                        'Jumlah Barang',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        '${barang['data']['jumlah']} buah',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
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
