import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herba_scan/app/data/Themes.dart';
import 'package:herba_scan/app/data/faq_item.dart';
import 'package:herba_scan/app/data/widgets/custom_expansion.dart';

class FaqView extends GetView {
  FaqView({super.key});

  final List<FAQItem> faqItems = [
    FAQItem(
      title: 'Penggunaan',
      content:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt '
          'ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco '
          'laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate '
          'velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, '
          'sunt in culpa qui officia deserunt mollit anim id est laborum.',
    ),
    FAQItem(
      title: 'Penggunaan',
      content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
    ),
    FAQItem(
      title: 'Penggunaan',
      content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
    ),
    FAQItem(
      title: 'Penggunaan',
      content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
                    Card(
                      elevation: 0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: faqItems.length,
                          itemBuilder: (context, index) {
                            return CustomExpansionTile(
                              faqItem: faqItems[index],
                              isLastItem: index == faqItems.length - 1,
                            );
                          },
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
