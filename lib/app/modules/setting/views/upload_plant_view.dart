import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herba_scan/app/data/Themes.dart';
import 'package:herba_scan/app/modules/setting/controllers/upload_plant_controller.dart';

class UploadPlantView extends GetView<UploadPlantController> {
  const UploadPlantView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadPlantController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.setLabel();
        },
        backgroundColor: Themes.buttonColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: Themes.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Themes.backgroundColor,
        title: Text(
          'Unggah Tanaman',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Obx(
            () => Column(
              children: [
                controller.isEmpty.value
                    ? emptyState()
                    : LeafCard(
                        "https://herba-scan-dashboard.edodev.my.id/storage/unclassified_plants/PcgGxxRLzGciaW2Xg66Bq22s03updrF6FlqSQyyz.jpg",
                        "Daun Sirih",
                        "Belum di verif",
                        "12/12/2021",
                      ),LeafCard(
                  "https://herba-scan-dashboard.edodev.my.id/storage/unclassified_plants/PcgGxxRLzGciaW2Xg66Bq22s03updrF6FlqSQyyz.jpg",
                  "Daun Sirih",
                  "Belum di verif",
                  "12/12/2021",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget emptyState() {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Text(
          'Belum ada tanaman yang diunggah',
          style: TextStyle(
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Image.asset('assets/images/not-found.png'),
      ],
    );
  }

  Widget LeafCard(String imageUrl, String name, String status, String date) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: PhysicalModel(
        color: Colors.white,
        elevation: 8,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: double.infinity,
          height: 280,
          decoration: BoxDecoration(
            // color: Colors.grey[300],
            borderRadius: BorderRadius.circular(24),
          ),
          child: Stack(
            children: [
              // Image
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.network(
                  imageUrl,
                  height: 280,
                  fit: BoxFit.contain,
                ),
              ),

              // Mask grey
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),

              // Text Information
              Positioned(
                left: 24,
                bottom: 24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
