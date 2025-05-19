import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../../../routes/app_pages.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Kotak biru di bagian atas (header)
            Container(
              height: 60,
              width: double.infinity,
              color: const Color(0xFF014D5E),
            ),

            // Konten utama scrollable
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 8),

                    // Logo
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

                    // Judul Selamat Datang
                    const Text(
                      "Selamat Datang Kembali!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF014D5E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "ayo masuk untuk penjelajahan berlanjut",
                      style: TextStyle(color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // Input Email
                    TextField(
                      controller: controller.emailC,
                      decoration: _inputDecoration("Masukkan email anda"),
                    ),
                    const SizedBox(height: 16),

                    // Input Password
                    TextField(
                      controller: controller.passC,
                      obscureText: true,
                      decoration: _inputDecoration("Password"),
                    ),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot password?",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Tombol Sign In
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.login(); // Fungsi login
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF014D5E),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Sign In"),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Divider OR
                    Row(
                      children: const [
                        Expanded(child: Divider(color: Color(0xFF014D5E))),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text("OR"),
                        ),
                        Expanded(child: Divider(color: Color(0xFF014D5E))),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Tombol Google
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: Image.asset("assets/logo/google-icon.png", width: 20),
                        label: const Text("Sign Up with Google"),
                        onPressed: () {
                          // Tambahkan auth Google jika ada
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Navigasi ke Register
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.REGISTER);
                      },
                      child: const Text(
                        "Belum punya akun? Daftar di sini",
                        style: TextStyle(
                          color: Color(0xFF014D5E),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
