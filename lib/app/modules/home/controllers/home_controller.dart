import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  // Scaffold key untuk mengakses drawer
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  
  // Observable variabel untuk slider
  final firstSliderIndex = 0.obs;
  
  // Method untuk update slider index
  void updateFirstSliderIndex(int index) {
    firstSliderIndex.value = index;
  }
  
  // Method untuk membuka drawer
  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }
  
  // Method logout untuk navigasi ke halaman login
  void logout() {
    // Di sini Anda bisa menambahkan kode untuk membersihkan data user jika diperlukan
    // Contoh: SharedPreferences.getInstance().then((prefs) => prefs.clear());
    // Atau jika menggunakan GetStorage: GetStorage().erase();
    
    // Navigasi ke halaman login dan hapus semua rute sebelumnya
    Get.offAllNamed(Routes.LOGIN);
  }
  
  // Method untuk navigasi ke halaman Absensi (Ringkasan Siswa)
  void navigateToAbsensi() {
    // Navigasi ke halaman ringkasan siswa
    Get.toNamed(Routes.ABSENSI);
  }
  
  // Method untuk navigasi ke halaman Profil
  void navigateToProfile() {
    // Navigasi ke halaman profil
    Get.toNamed(Routes.PROFILE);
  }
  
  // Method baru untuk navigasi ke halaman Edit Profile
  void navigateToEditProfile() {
    // Navigasi ke halaman edit profile
    Get.toNamed(Routes.EDIT_PROFILE);
  }

  // Method baru untuk navigasi ke halaman Informasi
  void navigateToInformasi() {
    // Navigasi ke halaman informasi
    Get.toNamed(Routes.INFORMASI);
  }
}