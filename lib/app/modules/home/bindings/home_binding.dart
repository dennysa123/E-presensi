import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Pastikan controller yang didaftarkan adalah HomeController yang benar
    // dari path modules/home/controllers/home_controller.dart
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}