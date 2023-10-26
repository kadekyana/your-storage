import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:your_storage/app/modules/BottomBar/views/bottom_bar_view.dart';

import '../controllers/edit_barang_controller.dart';

class EditBarangView extends GetView<EditBarangController> {
  EditBarangView({Key? key}) : super(key: key);
  final _formkey = GlobalKey<FormState>();

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
                top: 50,
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
              top: 80,
              left: 10,
              child: Text(
                'BARANG',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Positioned(
              bottom: 100,
              child: Container(
                width: MQW,
                height: MQH * 0.6,
                child: Card(
                  elevation: 10,
                  child: Form(
                    key: _formkey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextFormField(
                            // controller: _loginController.username,
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
                            keyboardType: TextInputType.datetime,
                            // controller: _loginController.username,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Tanggal Tidak Boleh Kosong";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                label: Text('Masukkan Tanggal'),
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.date_range)),
                          ),
                          SizedBox(
                            height: MQH * 0.01,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "jumlah Barang Tidak Boleh Kosong";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                label: Text('Masukkan Jumlah'),
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.add)),
                          ),
                          SizedBox(
                            height: MQH * 0.01,
                          ),
                          TextFormField(
                            // controller: _loginController.username,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Warna Tidak Boleh Kosong";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                label: Text('Masukkan Warna'),
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.color_lens)),
                          ),
                          SizedBox(
                            height: MQH * 0.01,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            // controller: _loginController.username,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Harga Tidak Boleh Kosong";
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
                          Spacer(),
                          Center(
                            child: FilledButton(
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  _formkey.currentState!.save();
                                  Get.to(BottomBarView());
                                  // return _loginController.login(
                                  //     _loginController.username.text,
                                  //     _loginController.password.text);
                                }
                              },
                              style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Color(0xffC0392B)),
                                padding: MaterialStatePropertyAll(
                                  EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 80),
                                ),
                              ),
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MQH * 0.04,
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
