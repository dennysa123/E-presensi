import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  // Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  // Text editing controllers
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nisnController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telefonController = TextEditingController();
  final TextEditingController kelasController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  
  // Observable variables
  final isLoading = false.obs;
  final profileImagePath = 'assets/logo/avatar.png'.obs;
  
  @override
  void onInit() {
    super.onInit();
    // Load data profil saat ini
    loadCurrentProfile();
  }
  
  @override
  void onClose() {
    // Dispose controllers
    namaController.dispose();
    nisnController.dispose();
    emailController.dispose();
    telefonController.dispose();
    kelasController.dispose();
    alamatController.dispose();
    super.onClose();
  }
  
  // Load data profil yang sudah ada
  void loadCurrentProfile() {
    // Di sini Anda bisa load data dari SharedPreferences, database, atau API
    // Untuk contoh, saya akan menggunakan data dummy
    namaController.text = 'Dennysa Adilla Nurizka';
    nisnController.text = '0089638447';
    emailController.text = 'dennysa@gmail.com';
    telefonController.text = '081234567890';
    kelasController.text = 'XII IPA 1';
    alamatController.text = 'Jl. Contoh Alamat No. 123, Jakarta';
  }
  
  // Validasi nama
  String? validateNama(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama tidak boleh kosong';
    }
    if (value.length < 3) {
      return 'Nama minimal 3 karakter';
    }
    return null;
  }
  
  // Validasi NISN
  String? validateNISN(String? value) {
    if (value == null || value.isEmpty) {
      return 'NISN tidak boleh kosong';
    }
    if (value.length != 10) {
      return 'NISN harus 10 digit';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'NISN hanya boleh berisi angka';
    }
    return null;
  }
  
  // Validasi email
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Format email tidak valid';
    }
    return null;
  }
  
  // Validasi telepon
  String? validateTelepon(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    }
    if (value.length < 10 || value.length > 13) {
      return 'Nomor telepon tidak valid';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Nomor telepon hanya boleh berisi angka';
    }
    return null;
  }
  
  // Validasi kelas
  String? validateKelas(String? value) {
    if (value == null || value.isEmpty) {
      return 'Kelas tidak boleh kosong';
    }
    return null;
  }
  
  // Validasi alamat
  String? validateAlamat(String? value) {
    if (value == null || value.isEmpty) {
      return 'Alamat tidak boleh kosong';
    }
    if (value.length < 10) {
      return 'Alamat terlalu pendek';
    }
    return null;
  }
  
  // Method untuk mengubah foto profil
  void changeProfileImage() {
    // Di sini Anda bisa implementasi image picker
    // Untuk contoh, saya akan menampilkan dialog pilihan
    Get.dialog(
      AlertDialog(
        title: const Text('Pilih Foto Profil'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Kamera'),
              onTap: () {
                Get.back();
                _pickImageFromCamera();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galeri'),
              onTap: () {
                Get.back();
                _pickImageFromGallery();
              },
            ),
          ],
        ),
      ),
    );
  }
  
  // Method untuk mengambil foto dari kamera
  void _pickImageFromCamera() {
    // Implementasi image picker dari kamera
    // Untuk sekarang hanya menampilkan snackbar
    Get.snackbar(
      'Info',
      'Fitur kamera akan segera tersedia',
      backgroundColor: const Color(0xFF05515D),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }
  
  // Method untuk mengambil foto dari galeri
  void _pickImageFromGallery() {
    // Implementasi image picker dari galeri
    // Untuk sekarang hanya menampilkan snackbar
    Get.snackbar(
      'Info',
      'Fitur galeri akan segera tersedia',
      backgroundColor: const Color(0xFF05515D),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }
  
  // Method untuk menyimpan perubahan profil
  Future<void> saveProfile() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    
    try {
      isLoading.value = true;
      
      // Simulasi proses penyimpanan data
      await Future.delayed(const Duration(seconds: 2));
      
      // Di sini Anda bisa implementasi penyimpanan ke database, API, atau SharedPreferences
      // Contoh: await saveToDatabase();
      
      // Tampilkan pesan sukses
      Get.snackbar(
        'Berhasil',
        'Profil berhasil diperbarui',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      
      // Kembali ke halaman sebelumnya
      Get.back();
      
    } catch (e) {
      // Tampilkan pesan error
      Get.snackbar(
        'Error',
        'Gagal memperbarui profil: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  // Method untuk menyimpan data ke database/API (implementasi sesuai kebutuhan)
  Future<void> saveToDatabase() async {
    // Contoh implementasi penyimpanan data
    final profileData = {
      'nama': namaController.text,
      'nisn': nisnController.text,
      'email': emailController.text,
      'telepon': telefonController.text,
      'kelas': kelasController.text,
      'alamat': alamatController.text,
      'profileImage': profileImagePath.value,
    };
    
    // Simpan ke SharedPreferences, database, atau kirim ke API
    print('Saving profile data: $profileData');
  }
}