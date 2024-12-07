import 'package:flutter/material.dart';

import 'package:get/get.dart';

class PlantDetailView extends StatefulWidget {
  final String plantName;
  final String imagePath;
  final String description;

  const PlantDetailView({
    Key? key,
    required this.plantName,
    required this.imagePath,
    required this.description,
  }) : super(key: key);

  @override
  _PlantDetailViewState createState() => _PlantDetailViewState();
}

class _PlantDetailViewState extends State<PlantDetailView> {
  int _selectedIndex = 0;

  // Konten untuk setiap tab
  final List<String> _tabContent = [
    'Deskripsi: Sirih adalah tanaman asli dari Indonesia...',
    'Manfaat: Daun sirih bermanfaat untuk kesehatan...',
    'Penggunaan: Daun sirih digunakan dalam berbagai...',
  ];

  // Fungsi untuk mengganti konten berdasarkan tab yang dipilih
  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[100],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Detail',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Tanaman
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                children: [
                  Image.asset(
                    widget.imagePath,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.plantName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          widget.description,
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
            const SizedBox(height: 20.0),
            // Tab Buttons (Deskripsi, Manfaat, Penggunaan)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTabButton('Deskripsi', 0),
                _buildTabButton('Manfaat', 1),
                _buildTabButton('Penggunaan', 2),
              ],
            ),
            const SizedBox(height: 16.0),
            // Konten berdasarkan tab yang dipilih
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _tabContent[_selectedIndex],
                  style: const TextStyle(fontSize: 14.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membuat tombol tab
  Widget _buildTabButton(String label, int index) {
    return ElevatedButton(
      onPressed: () => _onTabSelected(index),
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedIndex == index ? Colors.green[100] : Colors.grey[200],
        foregroundColor: _selectedIndex == index ? Colors.green : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Text(label),
    );
  }
}
