import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:herba_scan/app/data/models/auth/auth_user.dart';
import 'package:herba_scan/config.dart';

class AuthProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Config.BACKEND_API_URL;
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
      String email, String password, String c_password, String name) async {
    final res = await post('/api/v1/auth/register', {
      'email': email,
      'password': password,
      'c_password': c_password,
      'name': name
    });
    return res;
  }
}
