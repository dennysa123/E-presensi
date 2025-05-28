import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class AbsensiController extends GetxController {
  
  @override
  void onInit() {
    super.onInit();
    // Controller initialization if needed
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Submit attendance method
  void submitAbsen() {
    // Navigate directly to the presensi page
    Get.toNamed(Routes.PRESENSI);
  }
}