import 'package:flutter/material.dart';

class PhysicsAnimationPage extends StatelessWidget {
  const PhysicsAnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Physics Animation"),
        ),
        body: const Center(child: Text("Animation Category")));
  }
}
