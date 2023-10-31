import 'package:get/get.dart';

import '../controllers/check_global_network_controller.dart';

class CheckGlobalNetworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckGlobalNetworkController>(
      () => CheckGlobalNetworkController(),
    );
  }
}
