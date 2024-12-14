import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herba_scan/app/data/themes.dart';
import 'package:herba_scan/app/data/widgets/reusable_button.dart';
import 'package:herba_scan/app/data/widgets/reusable_input_field.dart';
import 'package:herba_scan/app/modules/setting/bindings/setting_binding.dart';
import 'package:herba_scan/app/modules/setting/controllers/setting_controller.dart';
import 'package:herba_scan/app/modules/setting/views/change_email_view.dart';

class ProfileView extends GetView<SettingController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Themes.backgroundColor,
        title: Text(
          'Edit Profil',
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
                const SizedBox(height: 40),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey[200],
                        child: GetX<SettingController>(
                          builder: (controller) {
                            final imageUrl =
                                controller.userController.user!.value.imageUrl;

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
                                width: 100,
                                height: 100,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.person_outlined,
                                    size: 110,
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
                    InkWell(
                      onTap: () {
                        controller.pickImage();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.white,
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Obx(
                        () => Column(
                          children: [
                            ReusableInputField(
                              title: 'Nama',
                              controller: controller.nameController,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Nama tidak boleh kosong';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                            ),
                            ReusableInputField(
                              title: 'E-mail',
                              enabled: false,
                              controller: controller.emailController,
                              validator: (val) => null,
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            ReusableButton(
                              text: 'Simpan',
                              onPressed: () {
                                if (formKey.currentState!.validate() &&
                                    !controller.isLoading.value) {
                                  controller.changeName();
                                }
                              },
                              isLoading: controller.isLoading.value,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ReusableButton(
                              isLoading: controller.isLoading.value,
                              text: 'Ubah E-mail',
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FontWeight.bold),
                              buttonStyle: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[400],
                                fixedSize: const Size(double.infinity, 50),
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate() &&
                                    !controller.isLoading.value) {
                                  Get.to(() => ChangeEmailView(),
                                      binding: SettingBinding());
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
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
