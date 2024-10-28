import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herba_scan/app/data/Themes.dart';
import 'package:herba_scan/app/data/widgets/reusable_button.dart';
import 'package:herba_scan/app/data/widgets/reusable_input_field.dart';
import 'package:herba_scan/app/modules/setting/controllers/setting_controller.dart';

class ChangeEmailView extends GetView {
  const ChangeEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingController());
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
                                controller: TextEditingController(),
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
                            ReusableButton(
                              text: 'Kirim kode',
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  Get.to(() => InputOtpView());
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

class InputOtpView extends GetView {
  const InputOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingController>();
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
                                controller: TextEditingController(),
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
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  Get.to(() => NewEmailView());
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

class NewEmailView extends GetView {
  const NewEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingController>();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: AppBar(
        backgroundColor: Themes.backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            // controller.newPassword.clear();
            // controller.cNewPassword.clear();
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
                                  ReusableInputField(
                                    title: 'Masukkan E-mail Baru',
                                    controller: TextEditingController(),
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
                                    suffixIcon: null,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            ReusableButton(
                              text: 'Simpan',
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  // controller.changePassword();
                                  Get.toNamed('/setting');
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
