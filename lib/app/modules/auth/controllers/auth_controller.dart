import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:herba_scan/app/data/models/auth/auth_user.dart';
import 'package:herba_scan/app/modules/auth/providers/auth_provider.dart';
import 'package:herba_scan/app/modules/auth/views/forget_password_view.dart';
import 'package:herba_scan/app/modules/home/providers/user_provider.dart';

class AuthController extends GetxController {
  // Forget Password
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController cNewPassword = TextEditingController();

  // Form input
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  final isLogin = true.obs;
  final isLoading = false.obs;

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
    //   prevent user to go back to login page
    checkTokenValid();
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
      isLoading.value = true;
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final response = await _authProvider.signInWithGoogle(googleUser);

        if (response.statusCode == 200) {
          box.write('token', Auth.fromJson(response.body).data.token);
          Get.offAllNamed('/home');
        } else {
          throw 'Permintaan Gagal';
        }
      }
      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
      Get.snackbar(
          'Terjadi Kesalahan', 'Silahkan coba lagi atau hubungi admin');
    }
  }

//   Logout
  Future<void> signOutGoogle() async {
    try {
      await _googleSignIn.signOut();
      box.remove('token');
    } catch (e) {
      Get.snackbar(
          'Terjadi Kesalahan', 'Silahkan coba lagi atau hubungi admin');
    }
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

  void checkTokenValid() async {
    final _userProvider = Get.put(UserProvider());
    final res = await _userProvider.getUser();
    if (res.statusCode == 401) {
      box.remove('token');
      Get.offAllNamed('/auth');
    } else if (res.statusCode == 200) {
      Get.offAllNamed('/home');
    }
  }

  Future<void> signIn() async {
    try {
      isLoading.value = true;
      if (formKey.currentState!.validate()) {
        final res = await _authProvider.signIn(
          emailController.text,
          passwordController.text,
        );
        if (res.statusCode == 200) {
          box.write('token', Auth.fromJson(res.body).data.token);
          Get.offAllNamed('/home');
        } else if (res.statusCode == 401) {
          Get.snackbar('Terjadi Kesalahan', 'Email atau Password Salah');
        } else {
          throw 'Permintaan Gagal';
        }
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
          'Terjadi Kesalahan', 'Silahkan coba lagi atau hubungi admin');
    }
  }

  Future<void> signUp() async {
    try {
      isLoading.value = true;
      if (formKey.currentState!.validate()) {
        final res = await _authProvider.signUp(
          emailController.text,
          passwordController.text,
          cPasswordController.text,
          nameController.text,
        );
        if (res.statusCode == 200) {
          box.write('token', Auth.fromJson(res.body).data.token);
          Get.offAllNamed('/home');
        } else {
          throw 'Permintaan Gagal';
        }
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Terjadi Kesalahan', 'Email sudah digunakan');
    }
  }

  Future<void> sendOtp() async {
    isLoading.value = true;
    final res = await _authProvider.sendOtp(emailController.text);

    if (res.statusCode == 200) {
      Get.snackbar('Berhasil', 'Kode OTP telah dikirim ke email anda');
      Get.to(() => const InputOtpView(), transition: Transition.rightToLeft);
    } else {
      Get.snackbar('Terjadi Kesalahan', 'Email tidak ditemukan');
    }
    isLoading.value = false;
  }

  Future<void> verifyOtp() async {
    isLoading.value = true;
    final res =
        await _authProvider.verfiyOtp(emailController.text, otpController.text);

    if (res.statusCode == 200) {
      Get.snackbar('Berhasil', 'Kode OTP valid');
      Get.to(() => NewPasswordView(), transition: Transition.rightToLeft);
    } else {
      Get.snackbar('Terjadi Kesalahan', 'Kode OTP salah');
    }
    isLoading.value = false;
  }

  Future<void> changePassword() async {
    isLoading.value = true;
    final res = await _authProvider.changePassword(
      emailController.text,
      otpController.text,
      newPassword.text,
      cNewPassword.text,
    );

    if (res.statusCode == 200) {
      Get.snackbar('Berhasil', 'Password berhasil diubah');
      Get.offAllNamed('/auth');
    } else {
      Get.snackbar('Terjadi Kesalahan', 'Gagal mengubah password');
    }
    isLoading.value = false;
  }
}
