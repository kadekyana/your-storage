import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:your_storage/app/modules/BottomBar/views/bottom_bar_view.dart';
import 'package:your_storage/app/modules/EditBarang/controllers/edit_barang_controller.dart';
import 'package:your_storage/app/widget/custom_date.dart';

class EditBarangView extends StatefulWidget {
  final dynamic detail;
  EditBarangView({Key? key, required this.detail}) : super(key: key);

  @override
  State<EditBarangView> createState() => _EditBarangViewState();
}

class _EditBarangViewState extends State<EditBarangView> {
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  final ImagePicker picker = ImagePicker();
  File? image;
  final _formkey = GlobalKey<FormState>();
  final EditBarangController controller = Get.put(EditBarangController());
  File? pickImage;

  final TextEditingController namaC = TextEditingController();
  final TextEditingController tanggalC = TextEditingController();
  final TextEditingController jumlahC = TextEditingController();
  final TextEditingController warnaC = TextEditingController();
  final TextEditingController hargaC = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Isi TextEditingControllers dengan data yang akan diubah
    namaC.text = widget.detail['data']['nama'];
    warnaC.text = widget.detail['data']['warna'];
    jumlahC.text = widget.detail['data']['jumlah'];
    hargaC.text = widget.detail['data']['harga'];
    tanggalC.text = widget.detail['data']['tanggal'];
  }

  @override
  void dispose() {
    namaC.dispose();
    warnaC.dispose();
    jumlahC.dispose();
    hargaC.dispose();
    tanggalC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int id = widget.detail['data']['id'] ?? '';
    print("id barang = $id");
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
                top: 80,
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
              top: 110,
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
                height: MQH * 0.75,
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
                          controller.dropdownForm(
                              items: ["Elektronik", "Non Elektronik"],
                              changeValue: (value) {
                                setState(() {
                                  controller..selectedValueDrop = value;
                                });
                              },
                              value: controller.selectedValueDrop),
                          _dateForm(
                              hintText: 'Tanggal Input', controller: tanggalC),
                          SizedBox(
                            height: MQH * 0.01,
                          ),
                          TextFormField(
                            controller: jumlahC,
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
                            controller: warnaC,
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
                            controller: hargaC,
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
                                GetBuilder<EditBarangController>(
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
                                Future.delayed(Duration(seconds: 1), () {
                                  btnController.success();
                                  Future.delayed(Duration(seconds: 1), () {
                                    controller.updateBarang(
                                        namaC.text,
                                        warnaC.text,
                                        jumlahC.text,
                                        hargaC.text,
                                        tanggalC.text,
                                        id,
                                        controller.picselect!);
                                    Get.to(BottomBarView());
                                  });
                                });
                              },
                              child: Text(
                                'Update Barang',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            // FilledButton(
                            //   onPressed: () {
                            //     if (_formkey.currentState!.validate()) {
                            //       _formkey.currentState!.save();
                            //       Get.to(BottomBarView());
                            //       controller.updateBarang(
                            //           namaC.text,
                            //           warnaC.text,
                            //           jumlahC.text,
                            //           hargaC.text,
                            //           tanggalC.text,
                            //           id,
                            //           controller.picselect!);
                            //     }
                            //   },
                            //   style: const ButtonStyle(
                            //     backgroundColor:
                            //         MaterialStatePropertyAll(Color(0xffC0392B)),
                            //     padding: MaterialStatePropertyAll(
                            //       EdgeInsets.symmetric(
                            //           vertical: 10, horizontal: 80),
                            //     ),
                            //   ),
                            //   child: Text(
                            //     'Edit',
                            //     style: TextStyle(
                            //         fontFamily: 'Poppins',
                            //         fontWeight: FontWeight.w700),
                            //   ),
                            // ),
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

  selectImage() async {
    XFile? pick = await picker.pickImage(source: ImageSource.gallery);

    if (pick != null) {
      setState(() {
        image = File(pick.path);
      });
    }
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
