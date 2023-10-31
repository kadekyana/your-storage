import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:your_storage/app/modules/QRCode/views/q_r_code_view.dart';

class QRCodeController extends GetxController {
  //TODO: Implement QRCodeController

  Dio dio = Dio();
  final String baseurl = 'https://wiwindendriani.000webhostapp.com/api/detail';
  dynamic barang;

  Future<void> detail(int selectId) async {
    try {
      final response = await dio.get("$baseurl/$selectId");
      if (response.statusCode == 200) {
        print(response.data);
        barang = response.data;
        print("data barang : $barang");
      }
    } catch (e) {
      print(e);
    }
  }

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
