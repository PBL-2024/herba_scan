import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herba_scan/app/data/themes.dart';
import 'package:herba_scan/app/data/widgets/reusable_app_bar.dart';
import 'package:herba_scan/app/modules/plant/controllers/plant_controller.dart';

class PlantDetailView extends GetView<PlantController> {
  const PlantDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final id = Get.parameters['id'];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getPlantById(int.parse(id!));
      controller.isFavorite(int.parse(id));
    });
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          controller.detailMenu.value = 0;
        }
      },
      child: Scaffold(
        backgroundColor: Themes.backgroundColor,
        appBar: ReusableAppBar(
          onPressed: () {
            Get.back();
          },
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
            onPressed: () {
              if (Get.previousRoute.isEmpty) {
                Get.offAllNamed('/home');
              } else {
                Get.back();
              }
              controller.detailMenu.value = 0;
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                controller.shareArticle(controller
                    .selectedPlant.value!);
              },
              icon: const Icon(Icons.share),
            ),
            Obx(
              () => IconButton(
                onPressed: () {
                  controller.setFavorite(int.parse(id!));
                },
                icon: Icon(
                  controller.isFavoritePlant.value
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: controller.isFavoritePlant.value
                      ? Colors.red
                      : Colors.black,
                ),
              ),
            ),
          ],
        ),
        body: Obx(
          () {
            if (controller.isLoading.value) {
              return _buildSkeleton();
            } else if (controller.selectedPlant.value?.id != null) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Gambar Tanaman
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Themes.backgroundColor2,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      controller
                                              .selectedPlant.value?.coverUrl ??
                                          'https://via.placeholder.com/150',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 12.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AutoSizeText(
                                          controller
                                                  .selectedPlant.value?.nama ??
                                              'Nama Tanaman',
                                          minFontSize: 25,
                                          softWrap: true,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            color: Themes.textGreenColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4.0),
                                        AutoSizeText(
                                          'Dilihat : ${controller.selectedPlant.value?.totalView ?? 0} kali',
                                          style: const TextStyle(
                                              color: Themes.buttonColor),
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
                            // Konten berdasarkan tab yang dipilih
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Deskripsi
                                    Visibility(
                                      visible: controller.detailMenu.value == 0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AutoSizeText(
                                            'Deskripsi',
                                            style: TextStyle(
                                              color: Themes.textGreenColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8.0),
                                          SingleChildScrollView(
                                            child: HtmlWidget(
                                              controller.selectedPlant.value
                                                      ?.deskripsi ??
                                                  '',
                                              textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Manfaat
                                    Visibility(
                                      visible: controller.detailMenu.value == 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AutoSizeText(
                                            'Manfaat',
                                            style: TextStyle(
                                              color: Themes.textGreenColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8.0),
                                          SingleChildScrollView(
                                            child: HtmlWidget(
                                              controller.selectedPlant.value
                                                      ?.manfaat ??
                                                  '',
                                              textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Penggunaan
                                    Visibility(
                                      visible: controller.detailMenu.value == 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AutoSizeText(
                                            'Penggunaan',
                                            style: TextStyle(
                                              color: Themes.textGreenColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8.0),
                                          SingleChildScrollView(
                                            child: HtmlWidget(
                                              controller.selectedPlant.value
                                                      ?.pengolahan ??
                                                  '',
                                              textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Card(
                        elevation: 5,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildTabButton('Deskripsi', 0),
                              _buildTabButton('Manfaat', 1),
                              _buildTabButton('Penggunaan', 2),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return _emptyRiwayat();
            }
          },
        ),
      ),
    );
  }

  // Fungsi untuk membuat tombol tab
  Widget _buildTabButton(String label, int index) {
    return ElevatedButton(
      onPressed: () {
        controller.detailMenu.value = index;
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: controller.detailMenu.value == index
            ? Themes.buttonColor
            : Colors.white,
        foregroundColor: controller.detailMenu.value == index
            ? Themes.backgroundColor
            : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: AutoSizeText(
        label,
        style: TextStyle(
            fontFamily:
                GoogleFonts.dmSans(fontWeight: FontWeight.w900).fontFamily),
      ),
    );
  }

  Widget _emptyRiwayat() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/not-found.png'),
          const SizedBox(height: 16),
          const Text(
            "Tanaman Tidak Di Temukan",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  _buildSkeleton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 16,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 16,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 16,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 16,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 16,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 16,
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }
}
