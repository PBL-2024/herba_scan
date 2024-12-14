import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:herba_scan/config.dart';

class AuthProvider extends GetConnect {
  @override
  void onInit() {
    GetStorage box = GetStorage();
    httpClient.baseUrl = Config.BACKEND_API_URL;
    httpClient.addRequestModifier<Object?>((request) {
      request.headers['Authorization'] = 'Bearer ${box.read('token')}';
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'application/json';
      return request;
    });
    httpClient.timeout = Duration(seconds: 30);
  }

  Future<Response> signInWithGoogle(GoogleSignInAccount auth) async {
    final response = await post('/api/v1/auth/google/callback', {
      'displayName': auth.displayName,
      'email': auth.email,
      'id': auth.id,
      'photoUrl': auth.photoUrl,
      'serverAuthCode': auth.serverAuthCode
    });
    return response;
  }

  Future<Response> signIn(String email, String password) async {
    final res = await post(
        '/api/v1/auth/login', {'email': email, 'password': password});

    return res;
  }

  Future<Response> signUp(
      String email, String password, String cPassword, String name) async {
    final res = await post('/api/v1/auth/register', {
      'email': email,
      'password': password,
      'c_password': cPassword,
      'name': name
    });
    return res;
  }

  Future<Response> logout() async {
    final res = await post('/api/v1/auth/logout', {});
    return res;
  }

  Future<Response> sendOtp(String email) async {
    final res = await post('/api/v1/auth/otp/send', {'email': email});
    return res;
  }

  Future<Response> sendOtpAuthenticatedUser(String email) async {
    final res = await post('/api/v1/auth/otp/send-authenticated-user', {'email': email});
    return res;
  }

  Future<Response> sendOtpSignUp(String email) async {
    final res = await post('/api/v1/auth/otp/signup/send', {'email': email});
    return res;
  }

  Future<Response> verfiyOtp(String email, String otp) async {
    final res =
        await post('/api/v1/auth/otp/verify', {'email': email, 'otp': otp});
    return res;
  }

  Future<Response> changePassword(
      String email, String token, String password, String cPassword) async {
    final res = await post('/api/v1/auth/change-password', {
      'email': email,
      'token': token,
      'password': password,
      'c_password': cPassword
    });
    return res;
  }
}
