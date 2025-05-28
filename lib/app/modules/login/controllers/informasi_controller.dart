import 'package:get/get.dart';

class InformasiController extends GetxController {
  var selectedCategory = 'Semua'.obs;
  var searchQuery = ''.obs;
  var filteredInformasi = <Map<String, dynamic>>[].obs;

  final List<String> categories = ['Semua', 'Akademik', 'Kegiatan', 'Pengumuman', 'Berita'];

  final informasiList = <Map<String, dynamic>>[
    {
      'id': 1,
      'title': 'Pengumuman Jadwal Ujian Tengah Semester',
      'description': 'Jadwal ujian tengah semester untuk periode Januari 2025 telah dirilis.',
      'category': 'Akademik',
      'date': '20 Jan 2025',
      'views': 245,
    },
    {
      'id': 2,
      'title': 'Workshop Digital Marketing untuk Siswa',
      'description': 'Kegiatan workshop digital marketing akan diadakan pada tanggal 25 Januari 2025.',
      'category': 'Kegiatan',
      'date': '18 Jan 2025',
      'views': 189,
    },
    {
      'id': 3,
      'title': 'Penerimaan Siswa Baru Tahun Ajaran 2025/2026',
      'description': 'Pendaftaran siswa baru untuk tahun ajaran 2025/2026 telah dibuka.',
      'category': 'Pengumuman',
      'date': '15 Jan 2025',
      'views': 567,
    },
    {
      'id': 4,
      'title': 'Prestasi Siswa dalam Olimpiade Matematika',
      'description': 'Selamat kepada siswa-siswa yang telah meraih prestasi dalam Olimpiade Matematika.',
      'category': 'Berita',
      'date': '12 Jan 2025',
      'views': 324,
    },
    {
      'id': 5,
      'title': 'Libur Semester Genap 2025',
      'description': 'Pengumuman jadwal libur semester genap tahun 2025.',
      'category': 'Akademik',
      'date': '10 Jan 2025',
      'views': 456,
    },
  ];

  @override
  void onInit() {
    super.onInit();
    filteredInformasi.assignAll(informasiList);
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
    _filterInformasi();
  }

  void searchInformasi(String query) {
    searchQuery.value = query;
    _filterInformasi();
  }

  void _filterInformasi() {
    var filtered = informasiList.where((info) {
      final matchCategory = selectedCategory.value == 'Semua' ||
          info['category'] == selectedCategory.value;

      final matchSearch = searchQuery.value.isEmpty ||
          info['title']
              .toString()
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()) ||
          info['description']
              .toString()
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase());

      return matchCategory && matchSearch;
    }).toList();

    filteredInformasi.assignAll(filtered);
  }
}