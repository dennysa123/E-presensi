import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var isLoading = false.obs;
  
  var nameError = ''.obs;
  var emailError = ''.obs;
  var phoneError = ''.obs;
  var passwordError = ''.obs;
  var confirmPasswordError = ''.obs;
  
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }
  
  void register() {
    // Reset errors
    nameError.value = '';
    emailError.value = '';
    phoneError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';
    
    // Validasi input
    bool isValid = true;
    
    if (nameController.text.isEmpty) {
      nameError.value = 'Nama tidak boleh kosong';
      isValid = false;
    }
    
    if (emailController.text.isEmpty) {
      emailError.value = 'Email tidak boleh kosong';
      isValid = false;
    } else if (!GetUtils.isEmail(emailController.text)) {
      emailError.value = 'Format email tidak valid';
      isValid = false;
    }
    
    if (phoneController.text.isEmpty) {
      phoneError.value = 'Nomor telepon tidak boleh kosong';
      isValid = false;
    }
    
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
    
    // Simulasi proses pendaftaran
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      Get.snackbar(
        'Berhasil', 
        'Pendaftaran berhasil, silahkan buat password baru',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
      
      // Navigasi ke halaman reset password setelah registrasi berhasil
      Get.toNamed('/reset-password');
    });
  }
  
  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}