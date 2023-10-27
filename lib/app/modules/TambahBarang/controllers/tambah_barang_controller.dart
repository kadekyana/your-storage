import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:your_storage/app/widget/custom_dropdown_button.dart';

class TambahBarangController extends GetxController {
  //TODO: Implement TambahBarangController
  final TextEditingController tanggal = TextEditingController();
  final TextEditingController kategori = TextEditingController();

  ImagePicker picker = ImagePicker();
  String selectedValueDrop = "Elektronik";
  XFile? picselect = null;

  void selectDropdown(value) {
    selectedValueDrop = value;
    update();
  }

  void selectImage() async {
    try {
      final select = await picker.pickImage(source: ImageSource.gallery);

      if (select != null) {
        print(select.name);
        print(select.path);
        picselect = select;
      }
      update();
    } catch (err) {
      print(err);
      picselect = null;
      update();
    }
  }

  void deleteImage() {
    picselect = null;
    update();
  }

  Column dropdownForm(
      {required List<String> items,
      required void Function(String) changeValue,
      required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        CustomDropdownButton(
            icon:
                const Icon(Icons.keyboard_arrow_down, color: Color(0xFF8F9098)),
            width: double.maxFinite,
            value: value,
            backgroundColor: Colors.white,
            changeValue: changeValue,
            items: items),
      ],
    );
  }

  // final count = 0.obs;
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  // void increment() => count.value++;
}
