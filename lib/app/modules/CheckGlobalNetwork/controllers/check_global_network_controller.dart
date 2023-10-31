import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckGlobalNetworkController extends GetxController {
  //TODO: Implement CheckGlobalNetworkController

  final Connectivity _connectivity = Connectivity();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(Status);
  }

  void Status(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.rawSnackbar(
          messageText: const Text(
            'Koneksi Terputus - Harap Sambung Kembali',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                color: Colors.white),
          ),
          isDismissible: false,
          duration: const Duration(days: 1),
          backgroundColor: const Color(0xffC0392B),
          icon: const Icon(
            Icons.wifi_off_rounded,
            color: Colors.white,
            size: 20,
          ),
          margin: EdgeInsets.zero,
          snackPosition: SnackPosition.TOP,
          snackStyle: SnackStyle.GROUNDED);
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
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
