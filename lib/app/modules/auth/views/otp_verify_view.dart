import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herba_scan/app/data/themes.dart';
import 'package:herba_scan/app/data/widgets/reusable_button.dart';
import 'package:herba_scan/app/data/widgets/reusable_input_field.dart';
import 'package:herba_scan/app/modules/auth/controllers/auth_controller.dart';

class OtpVerifyView extends GetView {
  const OtpVerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: AppBar(
        backgroundColor: Themes.backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Kode OTP',
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
              const SizedBox(
                height: 20,
              ),
              AutoSizeText(
                'Masukkan OTP untuk melanjutkan pendaftaran',
                style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.bold),
              ),
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
                      Image.asset('assets/images/forgot_password.png'),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Form(
                              key: formKey,
                              child: ReusableInputField(
                                title: 'Masukkan Kode OTP',
                                controller: controller.otpController,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Masukkan kode OTP";
                                  } else if (val.length < 6) {
                                    return "Kode OTP minimal 6 karakter";
                                  } else if (val.length > 6) {
                                    return "Kode OTP maksimal 6 karakter";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                obscureText: false,
                                suffixIcon: null,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Obx(
                              () => Column(
                                children: [
                                  ReusableButton(
                                    text: 'Verifikasi',
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        controller.signUp();
                                      }
                                    },
                                    isLoading: controller.isLoading.value,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ReusableButton(
                                    text: controller.countDown.value == 0
                                        ? 'Kirim Ulang Kode OTP'
                                        : 'Kirim Ulang Kode OTP (${controller.countDown.value})',
                                    onPressed: () {
                                      if (controller.countDown.value != 0) {
                                        return;
                                      }
                                      controller.sendOtpSignUp();
                                    },
                                    buttonStyle: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey,
                                      fixedSize:
                                          const Size(double.infinity, 50),
                                    ),
                                    isLoading: controller.isLoading.value,
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
