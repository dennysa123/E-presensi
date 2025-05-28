import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProfileController extends GetxController {
  // Observable variables untuk data profil user
  final userName = 'Denisa'.obs;
  final userNIS = '123456789'.obs;
  final userClass = 'Kelas 9A'.obs;
  final userEmail = 'denisaadilanurizka@gmail.com'.obs;
  final userPhone = '085852152127'.obs;
  final userAddress = 'Jl. Contoh Alamat No. 123, Jakarta'.obs;
  final userUsername = 'denisa'.obs;
  final userNISN = '0089638487'.obs;
  
  @override
  void onInit() {
    super.onInit();
    // Load data profil dari storage atau API
    loadProfileData();
  }
  
  // Method untuk load data profil dari storage atau API
  void loadProfileData() {
    // Di sini Anda bisa load data dari GetStorage, SharedPreferences, atau API
    // Contoh menggunakan GetStorage:
    // final box = GetStorage();
    // final profileData = box.read('profile_data');
    // if (profileData != null) {
    //   userName.value = profileData['nama'] ?? 'Denisa';
    //   userNISN.value = profileData['nisn'] ?? '0089638487';
    //   userClass.value = profileData['kelas'] ?? 'Kelas 9A';
    //   userEmail.value = profileData['email'] ?? 'denisaadilanurizka@gmail.com';
    //   userPhone.value = profileData['telepon'] ?? '085852152127';
    //   userAddress.value = profileData['alamat'] ?? 'Jl. Contoh Alamat No. 123, Jakarta';
    //   userUsername.value = profileData['username'] ?? 'denisa';
    // }
    
    // Untuk sekarang menggunakan data default
    fetchProfileData();
  }
  
  // Method untuk mengambil data profil dari API atau storage lokal
  void fetchProfileData() {
    // Simulasi pengambilan data (untuk contoh saja)
    Future.delayed(const Duration(milliseconds: 500), () {
      userName.value = 'Denisa';
      userNIS.value = '123456789';
      userClass.value = 'Kelas 9A';
      userEmail.value = 'denisaadilanurizka@gmail.com';
      userPhone.value = '085852152127';
      userAddress.value = 'Jl. Jakarta234';
      userUsername.value = 'denisa';
      userNISN.value = '0089638487';
    });
  }
  
  // Method untuk logout
  void logout() {
    // Hapus data sesi user
    // Contoh: jika menggunakan GetStorage
    // final box = GetStorage();
    // box.remove('user_token');
    // box.remove('user_data');
    // box.remove('profile_data');
    
    // Tampilkan konfirmasi logout
    Get.dialog(
      AlertDialog(
        title: const Text('Konfirmasi Logout'),
        content: const Text('Apakah Anda yakin ingin keluar?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Get.back(); // Tutup dialog
              // Navigasi ke halaman login dan hapus semua rute sebelumnya
              Get.offAllNamed('/login'); // Ganti dengan route yang sesuai
            },
            child: const Text('Ya, Keluar'),
          ),
        ],
      ),
    );
  }
  
  // Method untuk update profil
  void updateProfile({
    String? name, 
    String? nis, 
    String? className, 
    String? email, 
    String? phone, 
    String? address,
    String? username,
    String? nisn,
  }) {
    if (name != null) userName.value = name;
    if (nis != null) userNIS.value = nis;
    if (className != null) userClass.value = className;
    if (email != null) userEmail.value = email;
    if (phone != null) userPhone.value = phone;
    if (address != null) userAddress.value = address;
    if (username != null) userUsername.value = username;
    if (nisn != null) userNISN.value = nisn;
    
    // Simpan perubahan ke storage
    saveProfileData();
    
    // Update tampilan dengan data terbaru
    update();
  }
  
  // Method untuk menyimpan data profil
  void saveProfileData() {
    // Contoh menggunakan GetStorage:
    // final box = GetStorage();
    // final profileData = {
    //   'nama': userName.value,
    //   'nisn': userNISN.value,
    //   'kelas': userClass.value,
    //   'email': userEmail.value,
    //   'telepon': userPhone.value,
    //   'alamat': userAddress.value,
    //   'username': userUsername.value,
    // };
    // box.write('profile_data', profileData);
    
    print('Profile data saved: ${userName.value}, ${userEmail.value}');
  }
  
  // Method untuk refresh data profil
  void refreshProfile() {
    loadProfileData();
  }
  
  // Method untuk navigasi ke edit profile
  void goToEditProfile() {
    // Menggunakan Routes class yang sudah didefinisikan
    Get.toNamed('/edit-profile'); // Ganti dengan route yang sesuai
  }
  
  // Method untuk reload data setelah edit
  void onProfileEdited() {
    // Refresh data profil
    refreshProfile();
  }
}