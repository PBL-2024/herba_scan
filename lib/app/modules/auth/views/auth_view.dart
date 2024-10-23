import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herba_scan/app/data/Themes.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Image.asset(
                'assets/images/logo-tulisan.png',
                width: 200,
              ),
              const SizedBox(
                height: 50,
              ),
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
                      const SizedBox(
                        width: 20,
                      ),
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
                            // fontFamily: GoogleFonts.poppins().fontFamily,
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
                          ListTile(
                            title: Text(
                              'Masukkan Nama',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(0),
                            subtitle: TextFormField(
                              controller: controller.nameController,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Masukkan nama yang valid";
                                }
                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.emailAddress,
                              onEditingComplete: () =>
                                  FocusScope.of(context).nextFocus(),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ListTile(
                          title: Text(
                            'Masukkan E-mail',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(0),
                          subtitle: TextFormField(
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            onEditingComplete: () =>
                                FocusScope.of(context).nextFocus(),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Masukkan Kata Sandi',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(0),
                          subtitle: TextFormField(
                            controller: controller.passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: !controller.showPassword.value,
                            validator: (val) => val!.isEmpty
                                ? "Masukkan kata sandi yang valid"
                                : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: IconButton(
                                  onPressed: () => controller.togglePassword(),
                                  icon: Icon(
                                    controller.showPassword.value
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                  ),
                                ),
                              ),
                              suffixStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                            ),
                          ),
                        ),
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
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Themes.buttonColor,
                            fixedSize: const Size(double.infinity, 50),
                          ),
                          onPressed: () {
                            print(controller.nameController.text);
                            if (controller.formKey.currentState!.validate()) {}
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              textAlign: TextAlign.center,
                              controller.isLogin.value ? 'Masuk' : 'Daftar',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
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
                          fontFamily: GoogleFonts.poppins().fontFamily),
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
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: OutlinedButton.icon(
                  onPressed: () => controller.signInWithGoogle(),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Colors.black,
                    ),
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
                          const SizedBox(
                            width: 10,
                          ),
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
            ],
          ),
        ),
      ),
    );
  }
}
