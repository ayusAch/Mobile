import 'package:ballboys/app/Football/pages/ListNews.dart';
import 'package:flutter/material.dart';
import 'package:ballboys/app/Football/pages/listLiga.dart'; 

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Beranda',
        ),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.black
      ),
      //Bagian Header
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color:  Color.fromARGB(255, 165, 165, 173),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Selamat Datang',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Cari Informasi Seputar Sepakbola',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                        'assets/images/hacker.png',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Search bar
                Stack(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search_outlined,
                        ),
                        hintText: 'King Indo Lolos Piala Dunia 2026',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      bottom: 8,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 59, 69, 87),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.mic_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16), // Tambahkan jarak untuk memisahkan konten
          Expanded(
            child: LigaList(),
          ),
          // List News Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Berita Terbaru',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ListNews(), // Tambahkan widget ListNews
          ),
        ],
      ),
    );
  }
}
