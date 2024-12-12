import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herba_scan/app/data/Themes.dart';
import 'package:herba_scan/app/data/widgets/reusable_button.dart';
import 'package:herba_scan/app/data/widgets/reusable_input_field.dart';
import 'package:herba_scan/app/modules/auth/views/otp_verify_view.dart';
import 'package:herba_scan/app/routes/app_pages.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () => Get.offAllNamed(Routes.HOME),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Image.asset('assets/images/logo-tulisan.png', width: 200),
              const SizedBox(height: 50),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(10),
                child: Obx(
                  () => Wrap(
                    children: [

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: controller.isLogin.value
                              ? Themes.buttonColor
                              : Colors.white,
                        ),
                        onPressed: () => controller.toggleMenu(true),
                        child: Text(
                          'Masuk',
                          style: TextStyle(
                            color: controller.isLogin.value
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: controller.isLogin.value
                              ? Colors.white
                              : Themes.buttonColor,
                        ),
                        onPressed: () => controller.toggleMenu(false),
                        child: Text(
                          'Daftar',
                          style: TextStyle(
                            color: controller.isLogin.value
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(50),
                child: Form(
                  key: controller.formKey,
                  child: Obx(
                    () => Column(
                      children: [
                        if (!controller.isLogin.value)
                          ReusableInputField(
                            title: 'Masukkan Nama',
                            controller: controller.nameController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Masukkan nama yang valid";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                          ),
                        ReusableInputField(
                          title: 'Masukkan E-mail',
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
                        ),
                        ReusableInputField(
                          title: 'Masukkan Kata Sandi',
                          controller: controller.passwordController,
                          validator: (val) => val!.isEmpty
                              ? "Masukkan kata sandi yang valid"
                              : null,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !controller.showPassword.value,
                          suffixIcon: IconButton(
                            onPressed: () => controller.togglePassword(),
                            icon: Icon(
                              controller.showPassword.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                        ),
                        if (!controller.isLogin.value)
                          ReusableInputField(
                            title: 'Konfirmasi Kata Sandi',
                            controller: controller.cPasswordController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Masukkan kata sandi yang valid";
                              } else if (val !=
                                  controller.passwordController.text) {
                                return "Kata sandi tidak sama";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: !controller.showPassword.value,
                            suffixIcon: IconButton(
                              onPressed: () => controller.togglePassword(),
                              icon: Icon(
                                controller.showPassword.value
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                            ),
                          ),
                        if (controller.isLogin.value)
                          Container(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => Get.toNamed('/forget-password'),
                              child: Text(
                                'Lupa Kata Sandi?',
                                style: TextStyle(
                                  color: Themes.textButtonColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 20),
                        ReusableButton(
                          text: controller.isLogin.value ? 'Masuk' : 'Daftar',
                          onPressed: () async {
                            if (controller.formKey.currentState!.validate()) {
                              if (controller.isLogin.value) {
                                controller.signIn();
                              } else {
                                if (await controller.sendOtpSignUp()) {
                                  Get.to(const OtpVerifyView());
                                }
                              }
                            }
                          },
                          isLoading: controller.isLoading.value,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      height: 20,
                      thickness: 2,
                      endIndent: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Atau",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      height: 20,
                      thickness: 2,
                      indent: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: OutlinedButton.icon(
                  onPressed: () => controller.signInWithGoogle(),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black),
                    fixedSize: const Size(double.infinity, 50),
                  ),
                  label: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/icons/google-icon.png',
                            width: 25,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Masuk dengan akun Google',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
