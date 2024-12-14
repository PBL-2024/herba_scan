import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herba_scan/app/data/themes.dart';
import 'package:herba_scan/app/modules/setting/bindings/setting_binding.dart';
import 'package:herba_scan/app/modules/setting/views/change_password_view.dart';
import 'package:herba_scan/app/modules/setting/views/faq_view.dart';
import 'package:herba_scan/app/modules/setting/views/profile_view.dart';
import 'package:herba_scan/app/modules/setting/views/upload_plant_view.dart';
import 'package:herba_scan/app/routes/app_pages.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {
            Get.offNamed(Routes.HOME);
          },
        ),
        backgroundColor: Themes.backgroundColor,
        title: Text(
          'Pengaturan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => ProfileView());
                  },
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                    child: Obx(
                      () => ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey[200],
                            child: GetX<SettingController>(
                              builder: (controller) {
                                final imageUrl = controller
                                    .userController.user!.value.imageUrl;

                                if (imageUrl == null || imageUrl.isEmpty) {
                                  return const Icon(
                                    Icons.person_outlined,
                                    size: 40,
                                    color: Colors.grey,
                                  );
                                }

                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    width: 40,
                                    height: 40,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                        Icons.person_outlined,
                                        size: 40,
                                        color: Colors.grey,
                                      );
                                    },
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        title: AutoSizeText(
                          controller.userController.user!.value.name ??
                              'Data tidak ditemukan',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: AutoSizeText(
                          controller.userController.user!.value.email ??
                              'Data tidak ditemukan',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade600),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text(
                          "Umum",
                          style: TextStyle(
                              fontFamily: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                              ).fontFamily,
                              fontSize: 18,
                              color: Colors.grey.shade600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                ),
                                child: Icon(
                                  Icons.person_outlined,
                                  size: 30,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              title: Text(
                                'Edit profil',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: AutoSizeText(
                                'Ubah foto profile, email, dan nama',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade600),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                Get.to(() => ProfileView());
                              },
                            ),
                            ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                ),
                                child: Icon(
                                  Icons.lock_outline,
                                  size: 30,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              title: Text(
                                'Ubah Kata sandi',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: AutoSizeText(
                                'Memperbarui dan memperkuat keamanan akun',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade600),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                Get.to(() => ChangePasswordView());
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text(
                          "Preferensi",
                          style: TextStyle(
                              fontFamily: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                              ).fontFamily,
                              fontSize: 18,
                              color: Colors.grey.shade600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                ),
                                child: Icon(
                                  Icons.grass,
                                  size: 30,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              title: Text(
                                'Unggah Tanaman',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: AutoSizeText(
                                'Unggah tanaman yang belum di klasifikasi',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade600),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                Get.to(() => UploadPlantView(),
                                    binding: SettingBinding());
                              },
                            ),
                            ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                ),
                                child: Icon(
                                  Icons.info_outline,
                                  size: 30,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              title: Text(
                                'FAQ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: AutoSizeText(
                                'Pertanyaan yang sering diajukan',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade600),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                Get.to(() => FaqView(),
                                    binding: SettingBinding());
                              },
                            ),
                            ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                ),
                                child: Icon(
                                  Icons.logout_outlined,
                                  size: 30,
                                  color: Colors.red,
                                ),
                              ),
                              title: Text(
                                'Keluar',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              subtitle: AutoSizeText(
                                'Keluar akun dengan Aman',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade600),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                controller.logout();
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
