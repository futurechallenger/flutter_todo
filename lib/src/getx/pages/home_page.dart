import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Home page"),
        ElevatedButton(
            onPressed: () {
              Get.toNamed("/detail");
            },
            child: const Text("Detail")),
        ElevatedButton(
            onPressed: () {
              Get.toNamed("/settings");
            },
            child: const Text("Settings")),
      ],
    );
  }
}
