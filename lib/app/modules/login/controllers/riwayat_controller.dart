import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'presensi_controller.dart'; // Import PresensiController

class RiwayatController extends GetxController {
  // Filter options
  final filterOptions = ['Semua', 'Hadir', 'Izin', 'Sakit'];
  final currentFilter = 'Semua'.obs;
  
  // Date range for filtering
  final selectedMonth = DateTime.now().obs;
  final currentMonthText = ''.obs;
  
  // Attendance data from PresensiController and sample data
  final attendanceList = <Map<String, dynamic>>[].obs;
  final filteredAttendanceList = <Map<String, dynamic>>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    _updateMonthText();
    _loadAttendanceData();
    _filterAttendance();
    
    // Register this controller so PresensiController can find it
    print('RiwayatController initialized');
  }
  
  @override
  void onReady() {
    super.onReady();
    // Refresh data when the controller is ready
    refreshAttendanceData();
  }
  
  // Load attendance data from PresensiController and combine with sample data
  void _loadAttendanceData() {
    try {
      // Get real attendance data from PresensiController
      final realAttendanceData = PresensiController.getAllAttendanceRecords();
      print('Loaded ${realAttendanceData.length} real attendance records');
      
      // Generate some sample data for demonstration (only if no real data exists)
      final now = DateTime.now();
      final sampleData = realAttendanceData.isEmpty ? [
        {
          'date': DateTime(now.year, now.month, 20),
          'type': 'Hadir',
          'status': 'completed',
        },
        {
          'date': DateTime(now.year, now.month, 19),
          'type': 'Hadir',
          'status': 'completed',
        },
        {
          'date': DateTime(now.year, now.month, 18),
          'type': 'Izin',
          'status': 'completed',
        },
        {
          'date': DateTime(now.year, now.month - 1 > 0 ? now.month - 1 : 12, 25),
          'type': 'Hadir',
          'status': 'completed',
        },
        {
          'date': DateTime(now.year, now.month - 1 > 0 ? now.month - 1 : 12, 24),
          'type': 'Sakit',
          'status': 'completed',
        },
      ] : <Map<String, dynamic>>[];
      
      // Combine real data with sample data
      final combinedData = <Map<String, dynamic>>[];
      combinedData.addAll(realAttendanceData);
      
      // Add sample data only if it doesn't conflict with real data
      for (final sample in sampleData) {
        final sampleDate = sample['date'] as DateTime;
        final exists = realAttendanceData.any((real) {
          final realDate = real['date'] as DateTime;
          return realDate.year == sampleDate.year &&
                 realDate.month == sampleDate.month &&
                 realDate.day == sampleDate.day;
        });
        
        if (!exists) {
          combinedData.add(sample);
        }
      }
      
      // Sort by date descending
      combinedData.sort((a, b) {
        final dateA = a['date'] as DateTime;
        final dateB = b['date'] as DateTime;
        return dateB.compareTo(dateA);
      });
      
      attendanceList.assignAll(combinedData);
      print('Total attendance records loaded: ${attendanceList.length}');
      
    } catch (e) {
      print('Error loading attendance data: $e');
      // Fallback to sample data only
      _generateSampleData();
    }
  }
  
  // Generate sample attendance data (fallback)
  void _generateSampleData() {
    final now = DateTime.now();
    final sampleData = [
      {
        'date': DateTime(now.year, now.month, 15),
        'type': 'Hadir',
        'status': 'completed',
      },
      {
        'date': DateTime(now.year, now.month, 14),
        'type': 'Hadir',
        'status': 'completed',
      },
      {
        'date': DateTime(now.year, now.month, 13),
        'type': 'Izin',
        'status': 'completed',
      },
      {
        'date': DateTime(now.year, now.month, 12),
        'type': 'Hadir',
        'status': 'completed',
      },
      {
        'date': DateTime(now.year, now.month, 11),
        'type': 'Sakit',
        'status': 'completed',
      },
      {
        'date': DateTime(now.year, now.month, 10),
        'type': 'Hadir',
        'status': 'completed',
      },
      {
        'date': DateTime(now.year, now.month, 9),
        'type': 'Hadir',
        'status': 'completed',
      },
      {
        'date': DateTime(now.year, now.month, 8),
        'type': 'Izin',
        'status': 'completed',
      },
    ];
    
    attendanceList.assignAll(sampleData);
    print('Sample data generated: ${attendanceList.length} records');
  }
  
  // Refresh attendance data (called from PresensiController)
  void refreshAttendanceData() {
    print('Refreshing attendance data...');
    _loadAttendanceData();
    _filterAttendance();
    
    // Force UI update
    update();
  }
  
  void changeFilter(String filter) {
    currentFilter.value = filter;
    _filterAttendance();
  }
  
  void _filterAttendance() {
    try {
      List<Map<String, dynamic>> filtered = [];
      
      if (currentFilter.value == 'Semua') {
        filtered = attendanceList.toList();
      } else {
        filtered = attendanceList
            .where((item) => item['type'] == currentFilter.value)
            .toList();
      }
      
      // Filter by selected month
      filtered = filtered.where((item) {
        final itemDate = item['date'] as DateTime;
        return itemDate.year == selectedMonth.value.year &&
               itemDate.month == selectedMonth.value.month;
      }).toList();
      
      // Sort by date descending
      filtered.sort((a, b) {
        final dateA = a['date'] as DateTime;
        final dateB = b['date'] as DateTime;
        return dateB.compareTo(dateA);
      });
      
      filteredAttendanceList.assignAll(filtered);
      print('Filtered attendance list: ${filteredAttendanceList.length} records for ${currentMonthText.value}');
    } catch (e) {
      print('Error filtering attendance: $e');
      filteredAttendanceList.clear();
    }
  }
  
  void previousMonth() {
    try {
      final currentDate = selectedMonth.value;
      if (currentDate.month == 1) {
        selectedMonth.value = DateTime(currentDate.year - 1, 12, 1);
      } else {
        selectedMonth.value = DateTime(currentDate.year, currentDate.month - 1, 1);
      }
      _updateMonthText();
      _filterAttendance();
    } catch (e) {
      print('Error navigating to previous month: $e');
    }
  }
  
  void nextMonth() {
    try {
      final currentDate = selectedMonth.value;
      final now = DateTime.now();
      
      // Prevent going beyond current month
      if (currentDate.year > now.year || 
          (currentDate.year == now.year && currentDate.month >= now.month)) {
        Get.snackbar(
          'Informasi',
          'Tidak dapat melihat data bulan yang akan datang',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      
      if (currentDate.month == 12) {
        selectedMonth.value = DateTime(currentDate.year + 1, 1, 1);
      } else {
        selectedMonth.value = DateTime(currentDate.year, currentDate.month + 1, 1);
      }
      _updateMonthText();
      _filterAttendance();
    } catch (e) {
      print('Error navigating to next month: $e');
    }
  }
  
  void _updateMonthText() {
    try {
      final monthNames = [
        'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
        'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
      ];
      
      final month = selectedMonth.value.month;
      final year = selectedMonth.value.year;
      
      if (month >= 1 && month <= 12) {
        currentMonthText.value = '${monthNames[month - 1]} $year';
      } else {
        currentMonthText.value = 'Januari ${DateTime.now().year}';
      }
    } catch (e) {
      print('Error updating month text: $e');
      currentMonthText.value = 'Januari ${DateTime.now().year}';
    }
  }
  
  String formatDate(DateTime date) {
    try {
      final weekdays = ['Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];
      final months = [
        'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
        'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
      ];
      
      final weekday = date.weekday == 7 ? 0 : date.weekday; // Sunday = 0
      return '${weekdays[weekday]}, ${date.day} ${months[date.month - 1]} ${date.year}';
    } catch (e) {
      print('Error formatting date: $e');
      return 'Tanggal tidak valid';
    }
  }
  
  String formatDateShort(DateTime date) {
    try {
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    } catch (e) {
      print('Error formatting short date: $e');
      return '00/00/0000';
    }
  }
  
  // Get attendance statistics
  Map<String, int> getAttendanceStats() {
    try {
      final currentMonthData = attendanceList.where((item) {
        final itemDate = item['date'] as DateTime;
        return itemDate.year == selectedMonth.value.year &&
               itemDate.month == selectedMonth.value.month;
      }).toList();
      
      final hadir = currentMonthData.where((item) => item['type'] == 'Hadir').length;
      final izin = currentMonthData.where((item) => item['type'] == 'Izin').length;
      final sakit = currentMonthData.where((item) => item['type'] == 'Sakit').length;
      
      return {
        'hadir': hadir,
        'izin': izin,
        'sakit': sakit,
        'total': hadir + izin + sakit,
      };
    } catch (e) {
      print('Error calculating attendance stats: $e');
      return {
        'hadir': 0,
        'izin': 0,
        'sakit': 0,
        'total': 0,
      };
    }
  }
  
  // Get color for attendance type
  Color getTypeColor(String type) {
    switch (type) {
      case 'Hadir':
        return const Color(0xFF4CAF50);
      case 'Izin':
        return const Color(0xFFFF9800);
      case 'Sakit':
        return const Color(0xFFF44336);
      default:
        return const Color(0xFF05515D);
    }
  }
  
  // Get icon for attendance type
  IconData getTypeIcon(String type) {
    switch (type) {
      case 'Hadir':
        return Icons.check_circle;
      case 'Izin':
        return Icons.info_outline;
      case 'Sakit':
        return Icons.local_hospital_outlined;
      default:
        return Icons.circle;
    }
  }
  
  // Delete attendance record
  void deleteAttendanceRecord(DateTime date) {
    try {
      attendanceList.removeWhere((item) {
        final itemDate = item['date'] as DateTime;
        return itemDate.year == date.year &&
               itemDate.month == date.month &&
               itemDate.day == date.day;
      });
      
      _filterAttendance();
      
      Get.snackbar(
        'Berhasil',
        'Data presensi berhasil dihapus',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF4CAF50),
        colorText: Colors.white,
      );
    } catch (e) {
      print('Error deleting attendance record: $e');
      Get.snackbar(
        'Error',
        'Gagal menghapus data presensi',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFF44336),
        colorText: Colors.white,
      );
    }
  }
  
  // Export attendance data (placeholder for future implementation)
  void exportAttendanceData() {
    try {
      final currentMonthData = filteredAttendanceList.toList();
      
      if (currentMonthData.isEmpty) {
        Get.snackbar(
          'Informasi',
          'Tidak ada data untuk diekspor',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      
      // Placeholder for export functionality
      Get.snackbar(
        'Informasi',
        'Fitur ekspor akan segera tersedia',
        snackPosition: SnackPosition.BOTTOM,
      );
      
      print('Exporting ${currentMonthData.length} attendance records');
    } catch (e) {
      print('Error exporting attendance data: $e');
      Get.snackbar(
        'Error',
        'Gagal mengekspor data',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFF44336),
        colorText: Colors.white,
      );
    }
  }
}