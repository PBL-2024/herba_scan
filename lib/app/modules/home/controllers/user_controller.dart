import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:herba_scan/app/data/models/response_user.dart';
import 'package:herba_scan/app/data/widgets/reusable_button.dart';
import 'package:herba_scan/app/modules/auth/providers/auth_provider.dart';
import 'package:herba_scan/app/modules/home/providers/user_provider.dart';
import 'package:herba_scan/app/routes/app_pages.dart';

class UserController extends GetxController {
  late final Rx<User>? user = User().obs;
  final box = GetStorage();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  void getUser() async {
    if (!checkToken()) return;
    final userProvider = Get.put(UserProvider());
    final req = await userProvider.getUser();
    if (req.statusCode == 200) {
      final res = UserResponse.fromJson(req.body);
      user?.value = res.data!;
    }
  }

  Future<bool> logout() async {
    final Completer<bool> status = Completer();
    final authProvider = Get.put(AuthProvider());
    final req = await authProvider.logout();
    if (req.statusCode == 200) {
      box.remove('token');
      await _googleSignIn.signOut();
      status.complete(true);
    }else{
      status.complete(false);
    }
    return status.future;
  }

  bool checkToken() {
    return box.hasData('token');
  }

  void confirmAuth() {
    Get.defaultDialog(
      barrierDismissible: false,
      title: 'Peringatan',
      middleText: 'Anda harus login terlebih dahulu',
      actions: [
        ReusableButton(
          text: 'Login',
          onPressed: () {
            Get.offAllNamed(Routes.AUTH);
          },
        ),
        ReusableButton(
          text: 'Kembali',
          buttonStyle: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade700,
            fixedSize: const Size(double.infinity, 50),
          ),
          onPressed: () {
            Get.offAllNamed(Routes.HOME);
          },
        ),
      ],
    );
  }
}
