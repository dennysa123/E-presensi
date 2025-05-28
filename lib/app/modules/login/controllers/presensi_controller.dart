import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PresensiController extends GetxController {
  // Tab navigation
  var tabs = ['Hadir', 'Izin', 'Sakit'];
  var currentTab = 'Hadir'.obs;
  
  // Date management
  var currentMonth = 'Januari 2025'.obs;
  var currentMonthIndex = 1.obs; // January = 1
  var currentYear = 2025.obs;
  var selectedDate = Rxn<DateTime>();
  
  // Storage for attendance records (in-memory storage for this session)
  static final List<Map<String, dynamic>> _attendanceRecords = [];
  
  @override
  void onInit() {
    super.onInit();
    // Set initial selected date to the 10th of the current month
    selectedDate.value = DateTime(currentYear.value, currentMonthIndex.value, 10);
    
    // Initialize with current date
    final now = DateTime.now();
    currentYear.value = now.year;
    currentMonthIndex.value = now.month;
    _updateCurrentMonthText();
  }
  
  void changeTab(String tab) {
    currentTab.value = tab;
    // Keep the same selected date when changing tabs
  }
  
  // Mendapatkan jumlah hari dalam bulan tertentu
  int _getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }
  
  void previousMonth() {
    if (currentMonthIndex.value > 1) {
      currentMonthIndex.value--;
    } else {
      currentMonthIndex.value = 12;
      currentYear.value--;
    }
    _updateCurrentMonthText();
    
    // If the selected date is from a different month, update it to a valid date in the new month
    if (selectedDate.value != null) {
      int dayToSelect = selectedDate.value!.day;
      int daysInMonth = _getDaysInMonth(currentYear.value, currentMonthIndex.value);
      if (dayToSelect > daysInMonth) {
        dayToSelect = daysInMonth;
      }
      selectedDate.value = DateTime(currentYear.value, currentMonthIndex.value, dayToSelect);
    }
  }
  
  void nextMonth() {
    if (currentMonthIndex.value < 12) {
      currentMonthIndex.value++;
    } else {
      currentMonthIndex.value = 1;
      currentYear.value++;
    }
    _updateCurrentMonthText();
    
    // If the selected date is from a different month, update it to a valid date in the new month
    if (selectedDate.value != null) {
      int dayToSelect = selectedDate.value!.day;
      int daysInMonth = _getDaysInMonth(currentYear.value, currentMonthIndex.value);
      if (dayToSelect > daysInMonth) {
        dayToSelect = daysInMonth;
      }
      selectedDate.value = DateTime(currentYear.value, currentMonthIndex.value, dayToSelect);
    }
  }
  
  void _updateCurrentMonthText() {
    final monthNames = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    
    currentMonth.value = '${monthNames[currentMonthIndex.value - 1]} ${currentYear.value}';
  }
  
  void selectDate(DateTime date) {
    selectedDate.value = date;
    print('Selected date: ${_formatDate(date)}');
    // Use update() to trigger UI rebuild for GetBuilder widgets
    update();
  }
  
  // Format tanggal menjadi string YYYY-MM-DD tanpa package intl
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
  
  // Check if attendance already exists for the selected date
  bool _isAttendanceExistsForDate(DateTime date) {
    return _attendanceRecords.any((record) {
      final recordDate = record['date'] as DateTime;
      return recordDate.year == date.year &&
             recordDate.month == date.month &&
             recordDate.day == date.day;
    });
  }
  
  // Add attendance record to storage
  void _addAttendanceRecord(DateTime date, String type) {
    final newRecord = {
      'date': date,
      'type': type,
      'status': 'completed',
      'timestamp': DateTime.now(),
    };
    
    // Remove existing record for the same date if exists
    _attendanceRecords.removeWhere((record) {
      final recordDate = record['date'] as DateTime;
      return recordDate.year == date.year &&
             recordDate.month == date.month &&
             recordDate.day == date.day;
    });
    
    // Add new record
    _attendanceRecords.add(newRecord);
    
    // Sort records by date (newest first)
    _attendanceRecords.sort((a, b) {
      final dateA = a['date'] as DateTime;
      final dateB = b['date'] as DateTime;
      return dateB.compareTo(dateA);
    });
  }
  
  // Get all attendance records (static method to be accessible from RiwayatController)
  static List<Map<String, dynamic>> getAllAttendanceRecords() {
    return List.from(_attendanceRecords);
  }
  
  // Clear all attendance records (for testing purposes)
  static void clearAllRecords() {
    _attendanceRecords.clear();
  }
  
  void finishAttendance() {
    if (selectedDate.value == null) {
      Get.snackbar(
        'Error', 
        'Harap pilih tanggal terlebih dahulu',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      return;
    }
    
    final selectedDateFormatted = _formatDate(selectedDate.value!);
    final attendanceType = currentTab.value;
    
    // Check if attendance already exists for this date
    if (_isAttendanceExistsForDate(selectedDate.value!)) {
      Get.dialog(
        AlertDialog(
          title: const Text('Konfirmasi'),
          content: Text(
            'Presensi untuk tanggal $selectedDateFormatted sudah ada. Apakah Anda ingin menggantinya dengan $attendanceType?'
          ),
          actions: [
            TextButton(
              child: const Text('Batal'),
              onPressed: () => Get.back(),
            ),
            TextButton(
              child: const Text('Ya'),
              onPressed: () {
                Get.back();
                _submitAttendance(selectedDate.value!, attendanceType, selectedDateFormatted);
              },
            ),
          ],
        ),
      );
    } else {
      _submitAttendance(selectedDate.value!, attendanceType, selectedDateFormatted);
    }
  }
  
  void _submitAttendance(DateTime date, String attendanceType, String dateFormatted) {
    try {
      // Add to attendance records
      _addAttendanceRecord(date, attendanceType);
      
      // Here you would typically send the data to your API
      print('Submitting attendance: $attendanceType on $dateFormatted');
      
      // Update RiwayatController if it exists
      try {
        final riwayatController = Get.find<RiwayatController>();
        riwayatController.refreshAttendanceData();
      } catch (e) {
        print('RiwayatController not found: $e');
      }
      
      // Show success message
      Get.snackbar(
        'Berhasil',
        'Presensi $attendanceType berhasil dicatat pada tanggal $dateFormatted',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF4CAF50),
        colorText: const Color(0xFFFFFFFF),
        duration: const Duration(seconds: 3),
      );
      
      // Navigate to AbsensiView after a short delay
      Future.delayed(const Duration(seconds: 1), () {
        Get.offNamed('/absensi');
      });
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan saat menyimpan presensi: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }
  
  // Get attendance statistics for current month
  Map<String, int> getCurrentMonthStats() {
    final currentMonthRecords = _attendanceRecords.where((record) {
      final recordDate = record['date'] as DateTime;
      return recordDate.year == currentYear.value &&
             recordDate.month == currentMonthIndex.value;
    }).toList();
    
    final hadir = currentMonthRecords.where((record) => record['type'] == 'Hadir').length;
    final izin = currentMonthRecords.where((record) => record['type'] == 'Izin').length;
    final sakit = currentMonthRecords.where((record) => record['type'] == 'Sakit').length;
    
    return {
      'hadir': hadir,
      'izin': izin,
      'sakit': sakit,
      'total': hadir + izin + sakit,
    };
  }
}

// RiwayatController class that you'll need to create or modify
class RiwayatController extends GetxController {
  var attendanceHistory = <Map<String, dynamic>>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    refreshAttendanceData();
  }
  
  void refreshAttendanceData() {
    attendanceHistory.value = PresensiController.getAllAttendanceRecords();
    update();
  }
}