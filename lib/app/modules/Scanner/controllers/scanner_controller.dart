import 'dart:io';
import 'dart:typed_data';

import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ScannerController extends GetxController {
  //TODO: Implement ScannerController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
