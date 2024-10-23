import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ForgetPasswordView extends GetView {
  const ForgetPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ForgetPasswordView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ForgetPasswordView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
