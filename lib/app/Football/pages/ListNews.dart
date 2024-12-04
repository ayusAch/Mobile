import 'package:flutter/material.dart';

class ListNews extends StatelessWidget {
  // Data dummy berita
  final List<Map<String, String>> news = [
    {
      'title': 'Arsenal Siapkan Dana Besar Untuk Bajak Reijnders dari AC Milan',
      'date': '2 Desember 2024',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOcJi7XQ5chJjbT9c7cnNq85b-RGO_v26H_A&s',
    },
    {
      'title':
          'Filosofi Juventus Sudah Berubah, Namun Tetap Selalu Targetkan Kemenangan',
      'date': '26 November 2024',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSC18FBhxlXSUFYhFRxYkOzOEktWMFgfsvEag&s',
    },
    {
      'title': 'Pemain Terbaik Inggris Dunia 2024 Telah Dipilih',
      'date': '17 November 2024',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjGRPraRGLEgRwCrqkI_Ewj4dbghOjnX30uQ&s',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        final item = news[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Row(
            children: [
              // Gambar berita dengan ukuran seragam
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                  width: 120, // Lebar tetap
                  height: 100, // Tinggi tetap
                  color: Colors.grey.shade200, // Warna latar untuk loading
                  child: Image.network(
                    item['image']!,
                    fit: BoxFit.cover, // Menjaga gambar agar memenuhi kotak
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.broken_image,
                        color: Colors.grey,
                      ); // Placeholder jika gambar gagal dimuat
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16.0), // Jarak antar gambar dan teks

              // Judul dan tanggal
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title']!,
                      style: const TextStyle(
                        fontSize: 16.0, // Ukuran teks judul lebih kecil
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                        height: 8.0), // Jarak antara judul dan tanggal
                    Text(
                      item['date']!,
                      style: const TextStyle(
                        fontSize: 14.0, // Ukuran teks tanggal lebih kecil
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
