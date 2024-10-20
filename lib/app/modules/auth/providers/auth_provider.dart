import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:herba_scan/app/data/models/auth/google.dart';
import 'package:herba_scan/config.dart';

class AuthProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Config.BACKEND_API_URL;
  }

  Future<GoogleAuth?> signInWithGoogle(GoogleSignInAccount auth) async {
    final response = await post('/api/v1/auth/google/callback', {
      'displayName': auth.displayName,
      'email': auth.email,
      'id': auth.id,
      'photoUrl': auth.photoUrl,
      'serverAuthCode': auth.serverAuthCode
    });
    if (response.statusCode != 200) {
      return null;
    }
    return GoogleAuth.fromJson(response.body);
  }
}
