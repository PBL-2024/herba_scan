import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:herba_scan/app/modules/home/views/favorite_view.dart';
import 'package:herba_scan/app/modules/home/views/riwayat_view.dart';
import 'package:herba_scan/app/routes/app_pages.dart';
import 'package:herba_scan/app/modules/plant/views/plant_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.SETTING);
                          },
                          child: CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.green.shade200,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Hai!",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Selamat pagi",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.LEAF_SCAN);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green.shade200,
                        ),
                        child: const Icon(Icons.qr_code, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                decoration: BoxDecoration(
                  color: Color(0x889ED957),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(width: 20),
                    _buildTabButton("Beranda", true, context, null),
                    const SizedBox(width: 20),
                    _buildTabButton(
                        "Riwayat", false, context, const RiwayatView()),
                    const SizedBox(width: 20),
                    _buildTabButton(
                        "Favorit", false, context, const FavoriteView()),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
              // Tab Bar

              const SizedBox(height: 15),

              // Section: Tanaman
              _buildSectionTitle(context, "Tanaman"),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPlantCard(
                      "Lidah Buaya", "assets/images/lidah-buaya.png"),
                  _buildPlantCard(
                      "Lidah Buaya", "assets/images/lidah-buaya.png"),
                ],
              ),
              const SizedBox(height: 24),

              // Section: Artikel Kesehatan
              _buildSectionTitle(context, "Artikel Kesehatan"),
              const SizedBox(height: 8),
              _buildArticleCard("Daun Kemangi Bisa Buat Kaya...",
                  "assets/images/lidah-buaya.png"),
              const SizedBox(height: 8),
              _buildArticleCard("Daun Kemangi Bisa Buat Kaya...",
                  "assets/images/lidah-buaya.png"),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildTabButton(String label, bool isActive) {
  //   return Expanded(
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(vertical: 12),
  //       decoration: BoxDecoration(
  //         color: isActive ? Colors.green : Colors.white,
  //         borderRadius: BorderRadius.circular(24),
  //         border: isActive
  //             ? null
  //             : Border.all(color: Colors.green),
  //       ),
  //       child: Center(
  //         child: Text(
  //           label,
  //           style: TextStyle(
  //             fontWeight: FontWeight.bold,
  //             color: isActive ? Colors.white : const Color.fromARGB(255, 1, 120, 5),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget _buildTabButton(
    String label,
    bool isActive,
    BuildContext context,
    Widget? targetPage,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (targetPage != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => targetPage),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? Colors.green : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: isActive ? null : Border.all(color: Colors.green),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.white : Colors.green,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PlantView()),
            );
          },
          child: const Text(
            "Lihat semua",
            style: TextStyle(color: Colors.green),
          ),
        ),
      ],
    );
  }

  Widget _buildPlantCard(String name, String imagePath) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Image.asset(imagePath, height: 80),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          const Text(
            "Lidah buaya adalah tanaman yang sudah dikenal sejak lama.",
            style: TextStyle(fontSize: 12, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          const Text(
            "Baca Selengkapnya...",
            style: TextStyle(fontSize: 12, color: Colors.green),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleCard(String title, String imagePath) {
    return Container(
      padding: const EdgeInsets.only(right: 18, left: 12, top: 20, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Image.asset(imagePath, height: 50),
          const SizedBox(width: 2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const Text(
                  "Daun kemangi bisa buat kaya lho karena ...",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
