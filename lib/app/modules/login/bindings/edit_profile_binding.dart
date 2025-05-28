import 'package:get/get.dart';
import '../controllers/edit_profile_controller.dart';
import '../controllers/profile_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    // Pastikan ProfileController sudah ada atau buat jika belum
    // Karena EditProfile membutuhkan data dari ProfileController
    if (!Get.isRegistered<ProfileController>()) {
      Get.put<ProfileController>(ProfileController());
    }
    
    // Buat EditProfileController
    Get.lazyPut<EditProfileController>(
      () => EditProfileController(),
    );
  }
}