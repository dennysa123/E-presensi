import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ResetPasswordController extends GetxController {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  
  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;
  
  final RxString passwordError = ''.obs;
  final RxString confirmPasswordError = ''.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void resetPassword() {
    // Reset error messages
    passwordError.value = '';
    confirmPasswordError.value = '';
    
    // Validasi password
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    
    // Periksa apakah password kosong
    if (password.isEmpty) {
      passwordError.value = 'Password harus diisi';
      return;
    }
    
    // Periksa panjang password (minimal 6 karakter)
    if (password.length < 6) {
      passwordError.value = 'Password minimal 6 karakter';
      return;
    }
    
    // Periksa apakah konfirmasi password kosong
    if (confirmPassword.isEmpty) {
      confirmPasswordError.value = 'Konfirmasi password harus diisi';
      return;
    }
    
    // Periksa apakah password dan konfirmasi password cocok
    if (password != confirmPassword) {
      confirmPasswordError.value = 'Password tidak cocok';
      return;
    }
    
    // Set loading state
    isLoading.value = true;
    
    // Simulasi proses reset password (bisa diganti dengan API call)
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      
      // Reset text field
      passwordController.clear();
      confirmPasswordController.clear();
      
      // Navigate to home screen
      Get.offAllNamed('/home');
      
      // Tampilkan pesan sukses
      Get.snackbar(
        'Sukses',
        'Password berhasil diubah',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    });
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}