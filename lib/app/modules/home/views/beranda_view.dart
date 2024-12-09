import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herba_scan/app/data/Themes.dart';
import 'package:herba_scan/app/data/models/plant_response.dart';
import 'package:herba_scan/app/data/widgets/reusable_button.dart';
import 'package:herba_scan/app/modules/home/controllers/home_controller.dart';
import 'package:herba_scan/app/routes/app_pages.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BerandaView extends GetView<HomeController> {
  const BerandaView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.plantController.getPlant();
        await Future.delayed(const Duration(seconds: 1));
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _buildSectionTitle("Tanaman", Routes.PLANT),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(() {
                if (controller.plantController.isLoading.value) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:
                        List.generate(3, (index) => _buildSkeletonPlantCard()),
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: controller.plantController.plants.take(4).map((plant) {
                      return _buildPlantCard(plant);
                    }).toList(),
                  );
                }
              }),
            ),
            const SizedBox(height: 24),

            // Section: Artikel Kesehatan
            _buildSectionTitle("Artikel Kesehatan", Routes.ARTICLE),
            const SizedBox(height: 24),
            _buildArticleCard("Daun Kemangi Bisa Buat Kaya...",
                "assets/images/lidah-buaya.png", 'Deskripsi'),
            const SizedBox(height: 8),
            _buildArticleCard("Daun Kemangi Bisa Buat Kaya...",
                "assets/images/lidah-buaya.png", 'Deskripsi'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, String route) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 25,
            fontFamily:
                GoogleFonts.poppins(fontWeight: FontWeight.w700).fontFamily,
          ),
        ),
        const SizedBox(width: 8),
        ReusableButton(
          text: "Lihat Semua",
          width: 150,
          buttonStyle: ElevatedButton.styleFrom(
            backgroundColor: Themes.buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            Get.toNamed(route);
          },
        ),
      ],
    );
  }

  Widget _buildPlantCard(Plant plant) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.PLANT_DETAIL, parameters: {
          'id': plant.id!.toString(),
        });
      },
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  plant.coverUrl!,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              plant.nama!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 4),
            Container(
              constraints: BoxConstraints(maxHeight: 50), // Adjust the height as needed
              child: HtmlWidget(
                plant.deskripsi!,
                textStyle: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonPlantCard() {
    return Skeletonizer(
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 100,
              height: 16,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 4),
            Container(
              width: 150,
              height: 12,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleCard(String title, String imagePath, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.only(right: 18, left: 12, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Themes.backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: imagePath.startsWith('http')
                ? Image.network(
                    imagePath,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    imagePath,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    title,
                    style: TextStyle(
                      fontFamily:
                          GoogleFonts.poppins(fontWeight: FontWeight.w700)
                              .fontFamily,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  AutoSizeText(
                    description,
                    minFontSize: 10,
                    style: TextStyle(
                        color: Colors.grey,
                        fontFamily: GoogleFonts.poppins().fontFamily),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
