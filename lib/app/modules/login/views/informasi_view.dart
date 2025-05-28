import 'package:flutter/material.dart';

class InformasiView extends StatefulWidget {
  const InformasiView({Key? key}) : super(key: key);

  @override
  State<InformasiView> createState() => _InformasiViewState();
}

class _InformasiViewState extends State<InformasiView> {
  String selectedCategory = 'Semua';
  String searchQuery = '';
  List<Map<String, dynamic>> filteredInformasi = [];

  final List<String> categories = ['Semua', 'Akademik', 'Kegiatan', 'Pengumuman', 'Berita'];

  final List<Map<String, dynamic>> informasiList = [
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
  void initState() {
    super.initState();
    filteredInformasi = List.from(informasiList);
  }

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
      _filterInformasi();
    });
  }

  void searchInformasi(String query) {
    setState(() {
      searchQuery = query;
      _filterInformasi();
    });
  }

  void _filterInformasi() {
    filteredInformasi = informasiList.where((info) {
      final matchCategory = selectedCategory == 'Semua' ||
          info['category'] == selectedCategory;

      final matchSearch = searchQuery.isEmpty ||
          info['title']
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          info['description']
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase());

      return matchCategory && matchSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Informasi',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                onChanged: searchInformasi,
                decoration: const InputDecoration(
                  hintText: 'Cari informasi...',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Categories
          SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;
                
                return GestureDetector(
                  onTap: () => selectCategory(category),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue[600] : Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // Content
          Expanded(
            child: filteredInformasi.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Tidak ada informasi ditemukan',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: filteredInformasi.length,
                    itemBuilder: (context, index) {
                      final info = filteredInformasi[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getCategoryColor(info['category']),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    info['category'] ?? 'Umum',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  info['date'] ?? '',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              info['title'] ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              info['description'] ?? '',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                height: 1.5,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                const Icon(
                                  Icons.visibility,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${info['views'] ?? 0} views',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Membuka: ${info['title']}'),
                                        duration: const Duration(seconds: 2),
                                        backgroundColor: Colors.blue[600],
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue[600],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      'Baca Selengkapnya',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String? category) {
    switch (category) {
      case 'Akademik':
        return Colors.green[600]!;
      case 'Kegiatan':
        return Colors.blue[600]!;
      case 'Pengumuman':
        return Colors.orange[600]!;
      case 'Berita':
        return Colors.purple[600]!;
      default:
        return Colors.grey[600]!;
    }
  }
}