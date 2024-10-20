import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('AuthView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                controller.signInWithGoogle();
              },
              child: Text("Login with Google"),
            ),
            ElevatedButton(
              onPressed: () {
                controller.signOutGoogle();
              },
              child: Text("signOut"),
            ),
          ],
        ),
      ),
    );
  }
}
