import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herba_scan/app/data/themes.dart';
import 'package:herba_scan/app/data/widgets/plant_card.dart';
import 'package:herba_scan/app/modules/plant/controllers/plant_controller.dart';
import 'package:herba_scan/app/routes/app_pages.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlantView extends GetView<PlantController> {
  const PlantView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getPlant(filter: controller.filterSelected.value);
    });
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          controller.seachController.clear();
          controller.selectedPlant.value = null;
          controller.detailMenu.value = 0;
          controller.getPlant();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: Text(
            'Tanaman',
            style: TextStyle(
                color: Colors.black,
                fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w600)
                    .fontFamily),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
            onPressed: () {
              controller.getPlant();
              Get.back();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                controller: controller.seachController,
                decoration: InputDecoration(
                  hintText: 'Cari tanaman...',
                  suffixIcon: const Icon(Icons.search),
                  focusColor: Colors.green,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onEditingComplete: () {
                  controller.searchPlant();
                },
              ),
              const SizedBox(height: 16.0),
              // Filter Buttons
              Obx(
                () => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FilterButton(
                          label: 'Terbaru',
                          isSelected:
                              controller.filterSelected.value == 'terbaru',
                          onTap: () {
                            controller.filterSelected.value = 'terbaru';
                            controller.getPlant(filter: 'terbaru');
                          }),
                      FilterButton(
                        label: 'Populer',
                        isSelected:
                            controller.filterSelected.value == 'populer',
                        onTap: () {
                          controller.filterSelected.value = 'populer';
                          controller.getPlant(filter: 'populer');
                        },
                      ),
                      FilterButton(
                        label: 'Terfavorit',
                        isSelected:
                            controller.filterSelected.value == 'favorit',
                        onTap: () {
                          controller.filterSelected.value = 'favorit';
                          controller.getPlant(filter: 'terfavorit');
                        },
                      ),
                      FilterButton(
                        label: 'Paling Lama',
                        isSelected: controller.filterSelected.value == 'lama',
                        onTap: () {
                          controller.filterSelected.value = 'lama';
                          controller.getPlant(filter: 'terlama');
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Plant Cards
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Skeletonizer(
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return PlantCard(
                            imagePath: 'assets/images/not-found.png',
                            title: 'tes',
                            description: 'test',
                            onTap: () {},
                          );
                        },
                      ),
                    );
                  } else {
                    return RefreshIndicator(
                      onRefresh: () async {
                        controller.getPlant();
                        await Future.delayed(const Duration(seconds: 1));
                      },
                      child: ListView.builder(
                        itemCount: controller.plants.length,
                        itemBuilder: (context, index) {
                          final plant = controller.plants[index];
                          return PlantCard(
                            imagePath: plant.coverUrl!,
                            title: plant.nama!,
                            description: plant.deskripsi!,
                            onTap: () {
                              Get.toNamed(Routes.PLANT_DETAIL, parameters: {
                                'id': plant.id!.toString(),
                              });
                            },
                          );
                        },
                      ),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap; // Tambahkan onTap

  const FilterButton(
      {super.key, required this.label, this.isSelected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onTap, // Panggil onTap saat tombol ditekan
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Themes.buttonColor : Colors.grey[200],
          foregroundColor: isSelected ? Colors.white : Colors.black,
          textStyle: TextStyle(
              fontSize: 15,
              fontFamily:
                  GoogleFonts.poppins(fontWeight: FontWeight.w500).fontFamily),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
