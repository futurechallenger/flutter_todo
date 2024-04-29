import 'package:flutter/material.dart';

class ResponsivePage extends StatelessWidget {
  const ResponsivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Responsive Layout"),
      ),
      body: const Text('responsive layout'),
    );
  }
}
