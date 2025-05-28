import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/presensi_controller.dart';

class PresensiView extends GetView<PresensiController> {
  const PresensiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF05515D),
        elevation: 0,
        title: const Text(
          'Presensi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            onPressed: () => Get.back(),
          ),
        ),
      ),
      body: Column(
        children: [
          // Header Section with gradient
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF05515D),
                  Color(0xFF064A54),
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
            child: Column(
              children: [
                // Icon with modern styling
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.calendar_month_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Kalender Presensi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Pilih tanggal dan jenis kehadiran',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Modern Tab Selection
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
              border: Border.all(
                color: Colors.grey.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Obx(() => Row(
              children: controller.tabs.map((tab) {
                bool isSelected = controller.currentTab.value == tab;
                return Expanded(
                  child: InkWell(
                    onTap: () => controller.changeTab(tab),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? const Color(0xFF05515D).withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        tab,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelected ? const Color(0xFF05515D) : Colors.grey.shade600,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            )),
          ),
          
          const SizedBox(height: 24),
          
          // Month Navigation with modern design
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF05515D).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: InkWell(
                    onTap: () => controller.previousMonth(),
                    child: const Icon(
                      Icons.chevron_left,
                      color: Color(0xFF05515D),
                      size: 20,
                    ),
                  ),
                ),
                Obx(() => Text(
                  controller.currentMonth.value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF05515D),
                  ),
                )),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF05515D).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: InkWell(
                    onTap: () => controller.nextMonth(),
                    child: const Icon(
                      Icons.chevron_right,
                      color: Color(0xFF05515D),
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Calendar with modern styling
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Days of week header with modern styling
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Ming'
                      ].map((day) => Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFF05515D).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            day,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      )).toList(),
                    ),
                  ),
                  
                  // Calendar grid
                  Expanded(
                    child: _buildModernCalendarGrid(),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Modern finish button
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width * 0.6,
            height: 52,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF05515D),
                  Color(0xFF064A54),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF05515D).withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  controller.finishAttendance();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                      size: 22,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Selesai',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Beranda (Home) Button
            InkWell(
              onTap: () {
                try {
                  Get.toNamed('/home');
                } catch (e) {
                  print("Navigation error: $e");
                  Get.back();
                }
              },
              child: Image.asset(
                'assets/logo/logo-beranda.png',
                width: 32,
                height: 32,
                color: Colors.grey,
              ),
            ),
            
            // Absensi Button - currently selected
            InkWell(
              onTap: () {
                try {
                  Get.toNamed('/absensi');
                } catch (e) {
                  print("Navigation error: $e");
                  Get.back();
                }
              },
              child: Image.asset(
                'assets/logo/logo-absensi.png',
                width: 32,
                height: 32,
                color: const Color(0xFF05515D),
              ),
            ),
            
            // Profil Button
            InkWell(
              onTap: () {
                try {
                  Get.toNamed('/profile');
                } catch (e) {
                  print("Navigation error: $e");
                  Get.back();
                }
              },
              child: Image.asset(
                'assets/logo/logo-profile.png',
                width: 32,
                height: 32,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildModernCalendarGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.0,
      ),
      itemCount: 35, // 5 rows of 7 days
      itemBuilder: (context, index) {
        int row = index ~/ 7;
        int col = index % 7;
        
        // First row starts with empty cells until Wednesday (position 3)
        if (row == 0 && col < 3) {
          return Container(); // Empty cell
        }
        
        // Calculate the day number
        int dayNumber = index - 2; // Adjust based on starting position
        
        // Only show numbers from 1 to 31
        if (dayNumber > 0 && dayNumber <= 31) {
          // Using GetBuilder pattern instead of Obx
          return GetBuilder<PresensiController>(
            init: controller,
            builder: (_) {
              // Check if this day is selected using controller
              bool isSelected = controller.selectedDate.value?.day == dayNumber;
              
              return InkWell(
                onTap: () {
                  // When day is clicked, update the selected date in controller
                  controller.selectDate(DateTime(
                    controller.currentYear.value,
                    controller.currentMonthIndex.value,
                    dayNumber
                  ));
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: isSelected 
                        ? const LinearGradient(
                            colors: [
                              Color(0xFF05515D),
                              Color(0xFF064A54),
                            ],
                          )
                        : null,
                    color: isSelected 
                        ? null 
                        : Colors.grey.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected 
                          ? Colors.transparent
                          : Colors.grey.withOpacity(0.2),
                      width: 1,
                    ),
                    boxShadow: isSelected ? [
                      BoxShadow(
                        color: const Color(0xFF05515D).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ] : null,
                  ),
                  child: Center(
                    child: Text(
                      dayNumber.toString(),
                      style: TextStyle(
                        color: isSelected 
                            ? Colors.white 
                            : Colors.grey.shade700,
                        fontWeight: isSelected 
                            ? FontWeight.w700 
                            : FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              );
            }
          );
        } else {
          // Out of range for the month
          return Container();
        }
      },
    );
  }
}