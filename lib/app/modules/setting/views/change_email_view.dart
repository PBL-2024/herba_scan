import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herba_scan/app/data/Themes.dart';
import 'package:herba_scan/app/data/widgets/reusable_button.dart';
import 'package:herba_scan/app/data/widgets/reusable_input_field.dart';
import 'package:herba_scan/app/modules/auth/controllers/auth_controller.dart';
import 'package:herba_scan/app/modules/setting/bindings/setting_binding.dart';
import 'package:herba_scan/app/modules/setting/controllers/setting_controller.dart';

class ChangeEmailView extends GetView<SettingController> {
  const ChangeEmailView({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Ubah E-mail',
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
                'Masukkan E-mail untuk mendapatkan kode OTP',
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
                                title: 'Masukkan E-mail lama',
                                controller: controller.emailController,
                                validator: (val) {
                                  final regex = RegExp(
                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                                  );
                                  if (val == null || !regex.hasMatch(val)) {
                                    return "Masukkan email yang valid";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                obscureText: false,
                                suffixIcon: null,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Obx(
                              () => ReusableButton(
                                text: 'Kirim kode',
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    controller.sendOtp();
                                  }
                                },
                                isLoading: controller.isLoading.value,
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

class InputOtpView extends GetView<SettingController> {
  const InputOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: AppBar(
        backgroundColor: Themes.backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            // controller.otpController.clear();
            Get.back();
          },
        ),
        title: Text(
          'Ubah E-mail',
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
                'Cek email anda untuk mendapatkan kode OTP',
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
                      Image.asset('assets/images/mail_sent.png'),
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
                                title: 'Kode OTP',
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
                            ReusableButton(
                              text: 'Lanjut',
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  final res = await controller.verifyOtp(
                                      controller.emailController.text,
                                      controller.otpController.text);
                                  if (res) {
                                    Get.to(() => NewEmailView(),
                                        transition: Transition.rightToLeft);
                                  }
                                }
                              },
                              isLoading: false,
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

class NewEmailView extends GetView<SettingController> {
  const NewEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
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
          'Ubah E-mail',
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
                                  Obx(
                                    () => ReusableInputField(
                                      title: 'Masukkan E-mail Baru',
                                      controller: controller.newEmailController,
                                      validator: (val) {
                                        final regex = RegExp(
                                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                                        );
                                        if (val == null ||
                                            !regex.hasMatch(val)) {
                                          return "Masukkan email yang valid";
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      suffixIcon: TextButton(
                                        onPressed: () {
                                          if (controller.countDown.value <= 0 && controller.newEmailController.text.isNotEmpty) {
                                            controller.sendOtpToNewEmail();
                                          }else{
                                            formKey.currentState!.validate();
                                          }
                                        },
                                        child: Text(controller.countDown.value >
                                                0
                                            ? "Kirim ulang (${controller.countDown.value})"
                                                .toString()
                                            : 'Kirim kode OTP'),
                                      ),
                                    ),
                                  ),
                                  ReusableInputField(
                                    title: 'Kode OTP',
                                    controller:
                                        controller.otpNewEmailController,
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
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            Obx(
                              () => ReusableButton(
                                text: 'Simpan',
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    controller.changeEmail();
                                  }
                                },
                                isLoading: controller.isLoading.value,
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
