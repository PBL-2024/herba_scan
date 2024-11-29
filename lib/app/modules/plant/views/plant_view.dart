import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/plant_controller.dart';

class PlantView extends GetView<PlantController> {
  const PlantView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlantView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PlantView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
