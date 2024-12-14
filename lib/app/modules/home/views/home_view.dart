import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:herba_scan/app/data/themes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herba_scan/app/modules/home/controllers/home_controller.dart';
import 'package:herba_scan/app/modules/home/views/beranda_view.dart';
import 'package:herba_scan/app/modules/home/views/favorite_view.dart';
import 'package:herba_scan/app/modules/home/views/riwayat_view.dart';
import 'package:herba_scan/app/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0,left: 16.0,right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Themes.buttonColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Obx(
                          () => InkWell(
                            onTap: () {
                              if (controller.userController.checkToken()) {
                                Get.toNamed(Routes.SETTING);
                              } else {
                                controller.userController.confirmAuth();
                              }
                            },
                            child: controller
                                        .userController.user!.value.imageUrl !=
                                    null
                                ? CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(controller
                                        .userController.user!.value.imageUrl!),
                                  )
                                : CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Colors.green.shade200,
                                    child:
                                        Icon(Icons.person, color: Colors.white),
                                  ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hai!",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                            Obx(
                              () => Text(
                                controller.greeting.value,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                ),
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
                        child: const Icon(Icons.document_scanner,
                            color: Colors.white),
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
                  color: Themes.backgroundColor2,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(width: 20),
                      _buildTabButton(
                          "Beranda", controller.activeTab.value == "Beranda",
                          () {
                        controller.activeTab.value = "Beranda";
                      }),
                      const SizedBox(width: 20),
                      _buildTabButton(
                          "Riwayat", controller.activeTab.value == "Riwayat",
                          () {
                        controller.activeTab.value = "Riwayat";
                      }),
                      const SizedBox(width: 20),
                      _buildTabButton(
                          "Favorit", controller.activeTab.value == "Favorit",
                          () {
                        controller.activeTab.value = "Favorit";
                      }),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
              ),
              // Tab Bar

              const SizedBox(height: 15),

              // Content
              Obx(
                () {
                  if (controller.activeTab.value == "Beranda") {
                    return const BerandaView();
                  } else if (controller.activeTab.value == "Riwayat") {
                    return const RiwayatView();
                  } else if (controller.activeTab.value == "Favorit") {
                    return const FavoriteView();
                  } else {
                    return Container(); // Default case
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(
    String label,
    bool isActive,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
              color: isActive ? Themes.buttonColor : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(width: 2, color: Colors.white)),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
