import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herba_scan/app/data/widgets/reusable_app_bar.dart';
import 'package:herba_scan/app/modules/leaf-scan/controllers/leaf_scan_controller.dart';
import 'package:herba_scan/app/routes/app_pages.dart';

class ScanResultView extends GetView<LeafScanController> {
  const ScanResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(
        onPressed: () {
          Get.back();
        },
      ),
      backgroundColor: Colors.white,
      body: Obx(
        () => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.file(
                    fit: BoxFit.cover,
                    height: Get.height * 0.7,
                    File(controller.capturedImage.value),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.5),
                    spreadRadius: 10,
                    blurRadius: 20,
                    // offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  controller.plant.value.coverUrl == null
                      ? const CircularProgressIndicator()
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            controller.plant.value.coverUrl ?? '',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                  AutoSizeText(
                    softWrap: true,
                    controller.plant.value.nama ?? '',
                    style: TextStyle(
                      fontFamily:
                          GoogleFonts.poppins(fontWeight: FontWeight.bold)
                              .fontFamily,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: SizedBox(
                          height: 48,
                          width: 48,
                          child: IconButton(
                            onPressed: () {
                              Get.toNamed(Routes.PLANT_DETAIL, parameters: {
                                'id': controller.plant.value.id.toString(),
                              });
                            },
                            icon: const Icon(
                              Icons.info_outline,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: SizedBox(
                          height: 48,
                          width: 48,
                          child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.refresh,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
