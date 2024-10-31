import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herba_scan/app/data/Themes.dart';
import 'package:herba_scan/app/data/widgets/custom_expansion.dart';
import 'package:herba_scan/app/modules/setting/controllers/faq_controller.dart';

class FaqView extends GetView<FaqController> {
  const FaqView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FaqController());
    return Scaffold(
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
          'FAQ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/faq.png',
                        // Replace with your image
                        height: 200,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => Card(
                        elevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: controller.isLoading.value
                            ? CircularProgressIndicator(
                                color: Themes.buttonColor,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.faqItems.length,
                                  itemBuilder: (context, index) {
                                    return CustomExpansionTile(
                                      faqItem: controller.faqItems[index],
                                      isLastItem: index ==
                                          controller.faqItems.length - 1,
                                    );
                                  },
                                ),
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
    );
  }
}
