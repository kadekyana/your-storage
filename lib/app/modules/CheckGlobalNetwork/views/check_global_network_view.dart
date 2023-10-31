import 'package:get/get.dart';
import 'package:your_storage/app/modules/CheckGlobalNetwork/controllers/check_global_network_controller.dart';

class CheckGlobalNetwork {
  static void init() {
    Get.put<CheckGlobalNetworkController>(CheckGlobalNetworkController(),
        permanent: true);
  }
}
