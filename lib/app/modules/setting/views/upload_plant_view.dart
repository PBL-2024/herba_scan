import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herba_scan/app/data/Themes.dart';
import 'package:herba_scan/app/data/widgets/leaf_card.dart';
import 'package:herba_scan/app/modules/setting/controllers/upload_plant_controller.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UploadPlantView extends GetView<UploadPlantController> {
  const UploadPlantView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.selectSource();
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
          icon: Icon(Icons.arrow_back_ios_sharp),
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
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getUnclassifiedPlant();
          await Future.delayed(Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(
            child: GetX<UploadPlantController>(
              builder: (controller) {
                if (controller.isLoading.value) {
                  return Column(
                    children: [
                      Skeletonizer(
                        enabled: controller.isLoading.value,
                        child: LeafCard(
                            imageUrl: '',
                            name: 'Loading ...',
                            status: 'Loading ...',
                            date: 'Loading...'),
                      ),
                      Skeletonizer(
                        enabled: controller.isLoading.value,
                        child: LeafCard(
                            imageUrl: '',
                            name: 'Loading ...',
                            status: 'Loading ...',
                            date: 'Loading...'),
                      ),
                      Skeletonizer(
                        enabled: controller.isLoading.value,
                        child: LeafCard(
                            imageUrl: '',
                            name: 'Loading ...',
                            status: 'Loading ...',
                            date: 'Loading...'),
                      ),
                    ],
                  );
                } else if (controller.listUnclassifiedPlant.isEmpty) {
                  return emptyState();
                } else {
                  return Column(
                    children: [
                      for (var plant in controller.listUnclassifiedPlant)
                        InkWell(
                          onLongPress: () {
                            controller.deleteBottomSheet(plant.id!.toString());
                          },
                          child: LeafCard(
                            imageUrl: plant.fileUrl,
                            name: plant.nama,
                            status: plant.isVerified == 1
                                ? 'Terverifikasi'
                                : 'Belum Terverifikasi',
                            date: DateFormat('yyyy/MM/dd, HH:mm').format(
                              plant.createdAt!.add(
                                Duration(hours: 7),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                }
              },
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
}
