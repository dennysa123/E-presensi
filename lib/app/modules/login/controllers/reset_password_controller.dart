import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var isLoading = false.obs;
  
  var passwordError = ''.obs;
  var confirmPasswordError = ''.obs;
  
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }
  
  void resetPassword() {
    // Reset errors
    passwordError.value = '';
    confirmPasswordError.value = '';
    
    // Validasi input
    bool isValid = true;
    
    if (passwordController.text.isEmpty) {
      passwordError.value = 'Password tidak boleh kosong';
      isValid = false;
    } else if (passwordController.text.length < 6) {
      passwordError.value = 'Password minimal 6 karakter';
      isValid = false;
    }
    
    if (confirmPasswordController.text.isEmpty) {
      confirmPasswordError.value = 'Konfirmasi password tidak boleh kosong';
      isValid = false;
    } else if (confirmPasswordController.text != passwordController.text) {
      confirmPasswordError.value = 'Password tidak cocok';
      isValid = false;
    }
    
    if (!isValid) return;
    
    isLoading.value = true;
    
    // Simulasi proses reset password
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      Get.snackbar(
        'Berhasil', 
        'Password berhasil diubah',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
      
      // Navigasi ke halaman login setelah reset password berhasil
      Get.offAllNamed('/login');
    });
  }
  
  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}