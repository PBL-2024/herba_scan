import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:herba_scan/app/data/models/auth/google.dart';
import 'package:herba_scan/app/modules/auth/providers/auth_provider.dart';

class AuthController extends GetxController {
  // Form input
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final isLogin = true.obs;
  final showPassword = false.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final box = GetStorage();

  final AuthProvider _authProvider = Get.put(AuthProvider());
  static const List<String> scopes = <String>[
    'email',
    'profile',
    'openid',
    'https://www.googleapis.com/auth/userinfo.profile',
    'https://www.googleapis.com/auth/userinfo.email',
  ];

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: scopes,
  );

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleAuth? response =
            await _authProvider.signInWithGoogle(googleUser);

        if (response != null) {
          box.write('token', response.data.token);
          Get.offAllNamed('/home');
        } else {
          throw 'Permintaan Gagal';
        }
      }
    } catch (error) {
      Get.snackbar('Terjadi Kesalahan', error.toString());
    }
  }

//   Logout
  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
    box.remove('token');
  }

  void toggleMenu(bool isLogin) {
    this.isLogin.value = isLogin;
    // reset validation
    formKey.currentState!.reset();
    clearForm();
  }

  void togglePassword() {
    showPassword.value = !showPassword.value;
  }

  void clearForm() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
  }
}
