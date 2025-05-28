import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();

    // Munculkan logo secara animasi
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1;
      });
    });

    // Navigasi ke login setelah 3 detik
    Future.delayed(const Duration(seconds: 5), () {
      Get.offAllNamed('/login'); // ✅ Navigasi otomatis
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF004B58),
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 1),
          child: SizedBox(
            width: 200,
            height: 200,
            child: Image.asset(
              'assets/logo/logo-login.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
