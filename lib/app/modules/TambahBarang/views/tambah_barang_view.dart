import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:your_storage/app/modules/BottomBar/views/bottom_bar_view.dart';
import 'package:your_storage/app/widget/custom_date.dart';

import '../controllers/tambah_barang_controller.dart';

// ignore: must_be_immutable
class TambahBarangView extends StatefulWidget {
  TambahBarangView({Key? key}) : super(key: key);

  @override
  State<TambahBarangView> createState() => _TambahBarangViewState();
}

class _TambahBarangViewState extends State<TambahBarangView> {
  final _formkey = GlobalKey<FormState>();
  final TambahBarangController controller = Get.put(TambahBarangController());
  File? pickImage;

  Map<String, int> valueMapping = {
    "Elektronik": 1,
    "Non Elektronik": 2,
  };

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
                top: 40,
                left: 10,
                child: Text(
                  'TAMBAH',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                )),
            Positioned(
              top: 70,
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
              bottom: 0,
              child: Container(
                width: MQW,
                height: MQH * 0.8,
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
                            controller: controller.nama,
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
                          controller.dropdownForm(
                              items: ["", "Elektronik", "Non Elektronik"]
                                  .map((String item) {
                                return item;
                              }).toList(),
                              changeValue: (value) {
                                setState(() {
                                  controller..selectedValueDrop = value;
                                });
                              },
                              value: controller.selectedValueDrop),
                          _dateForm(
                              hintText: 'Tanggal Input',
                              controller: controller.tanggal),
                          SizedBox(
                            height: MQH * 0.01,
                          ),
                          TextFormField(
                            controller: controller.jumlah,
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
                            controller: controller.warna,
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
                            controller: controller.harga,
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
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GetBuilder<TambahBarangController>(
                                    builder: (controller) {
                                  if (controller.picselect != null) {
                                    return Row(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          child: CircleAvatar(
                                              radius: 50,
                                              backgroundImage: FileImage(File(
                                                  controller.picselect!.path))),
                                        ),
                                        IconButton(
                                            onPressed: () =>
                                                controller.deleteImage(),
                                            icon: Icon(Icons.delete)),
                                      ],
                                    );
                                  } else {
                                    return Text('No Image');
                                  }
                                }),
                                TextButton(
                                    onPressed: () => controller.selectImage(),
                                    child: Text('Choose')),
                              ],
                            ),
                          ),
                          Spacer(),
                          Center(
                            child: FilledButton(
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  _formkey.currentState!.save();
                                  Get.to(BottomBarView());
                                  controller.tambah(
                                      controller.nama.text,
                                      controller.warna.text,
                                      controller.jumlah.text,
                                      controller.harga.text,
                                      controller.tanggal.text);
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
                                'Tambah',
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

  Column _dateForm(
      {required String hintText, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        SuffixIconTextField(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2025));

            if (picked != null) {
              String formattedDate = DateFormat('dd-MM-yyy').format(picked);
              controller.text = formattedDate;
            }
          },
          hintText: hintText,
          controller: controller,
          icon: Icon(Icons.calendar_today),
        ),
      ],
    );
  }
}
