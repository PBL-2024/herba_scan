import 'package:flutter/material.dart';

class HerbaScanApp extends StatelessWidget {
  const HerbaScanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HerbaScan',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: Row(
          children: [
            const Icon(Icons.account_circle, size: 40),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Hallo...', style: TextStyle(fontSize: 18)),
                Text('Selamat pagi', style: TextStyle(fontSize: 14)),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.qr_code_scanner),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Navigation buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNavButton('Beranda'),
                _buildNavButton('Riwayat'),
                _buildNavButton('Favorit'),
              ],
            ),
            const SizedBox(height: 20),

            // Tanaman section
            _buildSectionHeader('Tanaman', onViewAllPressed: () {}),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildPlantCard('Lidah Buaya', 'Lidah buaya adalah sejenis tanaman yang...'),
                  _buildPlantCard('Lidah Buaya', 'Lidah buaya adalah sejenis tanaman yang...'),
                  // Add more plant cards if needed
                ],
              ),
            ),

            // Artikel Kesehatan section
            const SizedBox(height: 30),
            _buildSectionHeader('Artikel Kesehatan', onViewAllPressed: () {}),
            const SizedBox(height: 10),
            _buildArticleCard('Daun Kemangi Bisa Buat Kaya Lho...', 'Daun Kemangi Bisa Buat Kaya Lho karena...'),
            _buildArticleCard('Daun Kemangi Bisa Buat Kaya Lho...', 'Daun Kemangi Bisa Buat Kaya Lho karena...'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green[100],
          disabledBackgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {},
        child: Text(label),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {required VoidCallback onViewAllPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        TextButton(
          onPressed: onViewAllPressed,
          child: const Text('Lihat semua', style: TextStyle(color: Colors.green)),
        ),
      ],
    );
  }

  Widget _buildPlantCard(String name, String description) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const Image(
            image: AssetImage('assets/plant.png'), // Replace with your plant image
            height: 100,
          ),
          const SizedBox(height: 10),
          Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(description, maxLines: 2, overflow: TextOverflow.ellipsis),
          TextButton(
            onPressed: () {},
            child: const Text('Baca Selengkapnya...', style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleCard(String title, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const Image(
          image: AssetImage('assets/plant.png'), // Replace with your article image
          height: 50,
        ),
        title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(description, maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: TextButton(
          onPressed: () {},
          child: const Text('Lihat selengkapnya', style: TextStyle(color: Colors.green)),
        ),
      ),
    );
  }
}
