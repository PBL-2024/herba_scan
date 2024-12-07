import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:herba_scan/app/modules/home/views/home_view.dart';
import 'package:herba_scan/app/modules/plant/views/popular_view.dart';
import 'package:herba_scan/app/modules/plant/views/plant_view.dart';
import 'package:herba_scan/app/modules/plant/views/detail_view.dart';
import '../controllers/plant_controller.dart';



class LastView extends StatelessWidget {
  const LastView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PlantView()),
            );
          },
        ),
        title: const Text(
          'Tanaman',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari tanaman...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 16.0),
            // Filter Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilterButton(label: 'Paling Lama', isSelected: true),
                FilterButton(
                  label: 'Populer',
                  isSelected: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PlantView(),
                      ),
                    );
                  },
                ),
                FilterButton(
                  label: 'Terbaru',
                  isSelected: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PlantView(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // Plant Cards
            Expanded(
              child: ListView(
                children: [
                  PlantCard(
                    imagePath: 'assets/pepaya.png',
                    title: 'Daun Pepaya',
                    description: 'Daun Pepaya Bisa Buat Kaya Lho karena ...',
                    onTap: () {
                      // Navigasi ke halaman detail Daun Sirih
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlantDetailView(
                            plantName: 'Daun Sirih',
                            imagePath: 'assets/daun_sirih.png',
                            description: 'Deskripsi Daun Sirih...',
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12.0),
                  PlantCard(
                    imagePath: 'assets/sirih.png',
                    title: 'Daun Sirih',
                    description: 'Daun Sirih Bisa Buat Kaya Lho karena ...',
                    onTap: () {
                      // Navigasi ke halaman detail Daun Sirih
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlantDetailView(
                            plantName: 'Daun Sirih',
                            imagePath: 'assets/daun_sirih.png',
                            description: 'Deskripsi Daun Sirih...',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;  // Tambahkan onTap

  const FilterButton({Key? key, required this.label, this.isSelected = false, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,  // Panggil onTap saat tombol ditekan
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.green[100] : Colors.grey[200],
        foregroundColor: isSelected ? Colors.green : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Text(label),
    );
  }
}

class PlantCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final VoidCallback onTap; // Fungsi navigasi sebagai parameter

  const PlantCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.onTap, // Menerima fungsi navigasi
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Memanggil fungsi navigasi saat card ditekan
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Tanaman
            Image.asset(
              imagePath,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 12.0),
            // Info Tanaman
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    description,
                    style: const TextStyle(color: Colors.grey, fontSize: 12.0),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}