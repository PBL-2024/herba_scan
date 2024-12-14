import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herba_scan/app/data/themes.dart';
import 'package:herba_scan/app/data/models/riwayat_item.dart';
import 'package:herba_scan/app/modules/home/controllers/home_controller.dart';
import 'package:herba_scan/app/routes/app_pages.dart';

class RiwayatView extends GetView<HomeController> {
  const RiwayatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => controller.riwayat.isNotEmpty
                  ? Column(
                      children: controller.riwayat
                          .map((e) => _buildRiwayatCard(e))
                          .toList(),
                    )
                  : _emptyRiwayat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRiwayatCard(RiwayatItem item) {
    return GestureDetector(
      onTap: () async {
        if (item.type == 'tanaman') {
          Get.toNamed(Routes.PLANT_DETAIL,
              parameters: {'id': item.id.toString()});
        } else if (item.type == 'artikel') {
          Get.toNamed(Routes.ARTICLE_DETAIL,
              parameters: {'id': item.id.toString()});
        }else if (item.type == 'scan'){
          await controller.openRiwayatScan(item);
          Get.toNamed(Routes.SCAN_RESULT);
        }
      },
      onDoubleTap: () {
        controller.dialogConfirmDeleteAll();
      },
      onLongPress: () {
        controller.dialogConfirmDelete(item.hash);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding:
            const EdgeInsets.only(right: 18, left: 12, top: 10, bottom: 10),
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
              child: item.imgPath.startsWith('http')
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        item.imgPath,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(
                        File(item.imgPath),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
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
                      item.title,
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
                    Container(
                      constraints: BoxConstraints(maxHeight: 50),
                      // Adjust the height as needed
                      child: HtmlWidget(
                        controller.cutDescription(item.description),
                        textStyle: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
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
            "Riwayat Kosong",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Tidak ada riwayat yang tersimpan",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
