import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herba_scan/app/data/themes.dart';
import 'package:herba_scan/app/data/widgets/reusable_button.dart';
import 'package:herba_scan/app/data/widgets/reusable_input_field.dart';
// ignore: unused_import
import 'package:herba_scan/app/modules/auth/views/forget_password_view.dart';
import 'package:herba_scan/app/modules/setting/controllers/setting_controller.dart';
import 'package:herba_scan/app/routes/app_pages.dart';

class ChangePasswordView extends GetView {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingController());
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: AppBar(
        backgroundColor: Themes.backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Ubah Kata Sandi',
          style: TextStyle(
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  ReusableInputField(
                                    title: 'Masukkan Kata Sandi Lama',
                                    controller:
                                        controller.oldPasswordController,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "Kata sandi lama tidak boleh kosong";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    obscureText: true,
                                    suffixIcon: null,
                                  ),
                                  ReusableInputField(
                                    title: 'Masukkan Kata Sandi Baru',
                                    controller:
                                        controller.newPasswordController,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "Kata sandi lama tidak boleh kosong";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    obscureText: true,
                                    suffixIcon: null,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            Obx(
                              () => Column(
                                children: [
                                  ReusableButton(
                                    text: 'Simpan',
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        controller.changePassword();
                                      }
                                    },
                                    isLoading: controller.isLoading.value,
                                  ),
                                  const SizedBox(height: 20),
                                  ReusableButton(
                                    text: 'Lupa Kata Sandi',
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                        fontWeight: FontWeight.bold),
                                    buttonStyle: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey[400],
                                      fixedSize:
                                          const Size(double.infinity, 50),
                                    ),
                                    isLoading: controller.isLoading.value,
                                    onPressed: () =>
                                        Get.toNamed(Routes.FORGET_PASSWORD),
                                  ),
                                ],
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
    );
  }
}
