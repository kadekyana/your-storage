import 'package:get/get.dart';

import '../controllers/q_r_code_controller.dart';

class QRCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QRCodeController>(
      () => QRCodeController(),
    );
  }
}
