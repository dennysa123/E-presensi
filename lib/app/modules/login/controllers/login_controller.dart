import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final emailC = TextEditingController();
  final passC = TextEditingController();

  void login() {
    final email = emailC.text.trim();
    final password = passC.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email dan password harus diisi",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    } else {
      // Lakukan proses login (dummy navigation untuk sekarang)
      Get.offAllNamed(Routes.REGISTER);
    }
  }

  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();
    super.onClose();
  }
}
