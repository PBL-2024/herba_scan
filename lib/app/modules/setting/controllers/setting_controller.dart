import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herba_scan/app/data/models/response_avatar_update.dart';
import 'package:herba_scan/app/data/models/response_user.dart';
import 'package:herba_scan/app/data/widgets/reusable_button.dart';
import 'package:herba_scan/app/modules/auth/providers/auth_provider.dart';
import 'package:herba_scan/app/modules/home/controllers/user_controller.dart';
import 'package:herba_scan/app/modules/home/providers/user_provider.dart';
import 'package:herba_scan/app/modules/setting/bindings/setting_binding.dart';
import 'package:herba_scan/app/modules/setting/views/change_email_view.dart';
import 'package:image_picker/image_picker.dart';

class SettingController extends GetxController {
  final _userProvider = Get.put(UserProvider());
  final box = GetStorage();
  final isLoading = false.obs;
  final userController = Get.find<UserController>();

  // Profile
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  // Change Password
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  // Change Email
  final otpController = TextEditingController();
  final newEmailController = TextEditingController();
  final otpNewEmailController = TextEditingController();

  // count down timer
  final countDown = 0.obs;

  @override
  void onReady() {
    super.onReady();
    if(!userController.checkToken()){
      userController.confirmAuth();
    }else{
      nameController.text = userController.user!.value.name!;
      emailController.text = userController.user!.value.email!;
    }
  }


  void logout() {
    Get.bottomSheet(
      BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            width: double.infinity,
            child: Wrap(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    width: 60,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Apakah anda yakin ingin keluar?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ReusableButton(
                        text: 'Ya',
                        buttonStyle: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade700,
                          fixedSize: const Size(double.infinity, 50),
                        ),
                        onPressed: () async {
                          final status = await userController.logout();
                          status
                              ? 'Berhasil keluar'
                              : 'Gagal keluar';
                          Get.snackbar(
                              status ? 'Berhasil' : 'Gagal',
                              'Anda telah keluar dari aplikasi');
                          if (status) {
                            Get.offAllNamed('/home');
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      ReusableButton(
                        text: 'Tidak',
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> changeName() async {
    isLoading.value = true;
    final Map<String, dynamic> data = {
      'name': nameController.text,
    };
    _userProvider.updateUser(data).then((value) {
      if (value.statusCode == 200) {
        Get.snackbar('Berhasil', 'Nama berhasil diubah');
        userController.getUser();
      } else {
        Get.snackbar('Gagal', 'Gagal mengubah nama');
      }
      isLoading.value = false;
    });
  }

  Future<void> pickImage() async {
    Get.bottomSheet(
      BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            height: 150,
            width: double.infinity,
            child: Column(
              children: [
                //   Black line
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: 60,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Kamera'),
                  onTap: () async {
                    pickAndUploadImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo),
                  title: Text('Galeri'),
                  onTap: () async {
                    pickAndUploadImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> pickAndUploadImage(ImageSource source) async {
    try {
      Get.back();
      final image = await ImagePicker()
          .pickImage(source: source, maxHeight: 500, imageQuality: 50);
      if (image == null) return;

      final response = await _userProvider.updateImage(image);
      final res = AvatarUpdateResponse.fromJson(response.body);

      Get.snackbar(
          response.statusCode == 200 ? 'Berhasil' : 'Gagal', res.message!);
      userController.getUser();
    } catch (e) {
      Get.snackbar("Gagal", "Terjadi kesalahan");
    }
  }

  void changePassword() async {
    isLoading.value = true;
    final response = await _userProvider.changePassword({
      'old_password': oldPasswordController.text,
      'new_password': newPasswordController.text,
    });
    if (response.statusCode == 200) {
      Get.snackbar('Berhasil', 'Kata sandi berhasil diubah');
      Get.toNamed('/setting');
    } else {
      Get.snackbar('Gagal',
          'Kata sandi gagal diubah,periksa kembali kata sandi lama anda');
    }
    isLoading.value = false;
    // clear text field
    oldPasswordController.clear();
    newPasswordController.clear();
  }

  Future<void> sendOtp(String otp) async {
    isLoading.value = true;
    final authProvider = Get.put(AuthProvider());
    final userProvider = Get.put(UserProvider());

    final responseUser = await userProvider.getUser();
    final user = UserResponse.fromJson(responseUser.body);

    if (otp != user.data!.email) {
      Get.snackbar('Terjadi Kesalahan', 'Email tidak sesuai');
      isLoading.value = false;
      return;
    }

    final res = await authProvider.sendOtp(otp);

    if (res.statusCode == 200) {
      Get.snackbar('Berhasil', 'Kode OTP telah dikirim ke email anda');
      Get.to(() => const InputOtpView(),
          transition: Transition.rightToLeft, binding: SettingBinding());
    } else {
      Get.snackbar('Terjadi Kesalahan', 'Email tidak ditemukan');
    }
    isLoading.value = false;
  }

  Future<bool> verifyOtp(String email, String otp) async {
    isLoading.value = true;
    final authProvider = Get.put(AuthProvider());
    final res = await authProvider.verfiyOtp(email, otp);
    if (res.statusCode == 200) {
      isLoading.value = false;
      return true;
    } else {
      Get.snackbar('Terjadi Kesalahan', 'Kode OTP salah');
      isLoading.value = false;
      return false;
    }
  }

  Future<void> changeEmail() async {
    isLoading.value = true;
    // check if otp is valid
    final isOtpValid =
        await verifyOtp(newEmailController.text, otpNewEmailController.text);
    if (!isOtpValid) {
      isLoading.value = false;
      return;
    }
    final userProvider = Get.put(UserProvider());
    final data = {
      'email': newEmailController.text,
    };
    userProvider.updateUser(data).then((value) {
      final userRes = UserResponse.fromJson(value.body);
      if (value.statusCode == 200) {
        Get.snackbar('Berhasil', 'Email berhasil diubah');
        isLoading.value = false;
        Get.offAllNamed('/setting');
        userController.getUser();
      } else {
        Get.snackbar('Gagal', userRes.message!);
      }
    });
    isLoading.value = false;
  }

  void sendOtpToNewEmail() async {
    if (countDown.value > 0) return;
    isLoading.value = true;
    setCountDown();
    final userProvider = Get.put(UserProvider());
    final data = {
      'email': newEmailController.text,
    };
    final res = await userProvider.sendOtp(data);
    if (res.statusCode == 200) {
      Get.snackbar('Berhasil', 'Kode OTP telah dikirim ke email anda');
    } else {
      Get.snackbar('Terjadi Kesalahan', "Email sudah terdaftar");
    }
    isLoading.value = false;
  }

  Future<void> setCountDown() async {
    countDown.value = 15;
    for (var i = 15; i >= 0; i--) {
      await Future.delayed(Duration(seconds: 1));
      countDown.value = i;
    }
  }
}
