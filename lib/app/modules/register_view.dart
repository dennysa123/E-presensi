import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_presensi/app/modules/login/controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFF014D5E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Image.asset("assets/logo/logo-login.png"),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Ayo Kita Mulai",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Buat akun baru untuk memulai",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),

              Obx(() => TextField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  labelText: "Nama Lengkap",
                  hintText: "Masukkan nama lengkap",
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorText: controller.nameError.value.isEmpty ? null : controller.nameError.value,
                ),
              )),
              const SizedBox(height: 16),

              Obx(() => TextField(
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Masukkan email",
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorText: controller.emailError.value.isEmpty ? null : controller.emailError.value,
                ),
              )),
              const SizedBox(height: 16),

              Obx(() => TextField(
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Nomor Telepon",
                  hintText: "Masukkan nomor telepon",
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorText: controller.phoneError.value.isEmpty ? null : controller.phoneError.value,
                ),
              )),
              const SizedBox(height: 16),

              Obx(() => TextField(
                controller: controller.passwordController,
                obscureText: !controller.isPasswordVisible.value,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Masukkan password",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () => controller.togglePasswordVisibility(),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorText: controller.passwordError.value.isEmpty ? null : controller.passwordError.value,
                ),
              )),
              const SizedBox(height: 16),

              Obx(() => TextField(
                controller: controller.confirmPasswordController,
                obscureText: !controller.isConfirmPasswordVisible.value,
                decoration: InputDecoration(
                  labelText: "Konfirmasi Password",
                  hintText: "Masukkan konfirmasi password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isConfirmPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () => controller.toggleConfirmPasswordVisibility(),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorText: controller.confirmPasswordError.value.isEmpty ? null : controller.confirmPasswordError.value,
                ),
              )),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value ? null : () => controller.register(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF014D5E),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Daftar", style: TextStyle(fontSize: 16)),
                )),
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Sudah memiliki akun?"),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text(
                      "Masuk",
                      style: TextStyle(
                        color: const Color(0xFF014D5E),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}