import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF004B58),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.event_note), label: "Absensi"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFF004B58),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.menu, color: Colors.white),
                    Spacer(),
                    Text("E-Presensi", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage("assets/images/avatar.png"), // Ganti dengan path asset gambar kamu
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Selamat Datang!", style: TextStyle(color: Colors.white)),
                        Text("Dennysa Adilla Nurizka", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 4)],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Minggu"),
                    Text("13 Januari 2025"),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatBox("Hadir", controller.hadir),
                    _buildStatBox("Izin", controller.izin),
                    _buildStatBox("Sakit", controller.sakit),
                    _buildStatBox("Alpha", controller.alpha),
                  ],
                ),
              ],
            ),
          ),
          // Tambah placeholder untuk carousel
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: AssetImage("assets/images/banner.jpg"), // ganti sesuai gambar kamu
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Chart Section - kamu bisa gunakan package chart seperti `fl_chart`
          const Text("Chart Presensi Mingguan (dummy)"),
        ],
      ),
    );
  }

  Widget _buildStatBox(String label, RxInt value) {
    return Obx(() => Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.orange[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                value.value.toString(),
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            const SizedBox(height: 4),
            Text(label),
          ],
        ));
  }
}
