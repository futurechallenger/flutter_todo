import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class PhysicsAnimationPage extends StatefulWidget {
  const PhysicsAnimationPage({super.key});

  @override
  State<PhysicsAnimationPage> createState() => _PhysicsAnimationPageState();
}

class _PhysicsAnimationPageState extends State<PhysicsAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, upperBound: 500)
      ..addListener(() {
        setState(() {});
      });

    final simulation = SpringSimulation(
        const SpringDescription(mass: 1, stiffness: 10, damping: 1),
        0,
        300,
        10);

    _controller.animateWith(simulation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Physics Animation"),
        ),
        body: Stack(children: [
          Positioned(
            left: 50,
            top: _controller.value,
            height: 40,
            width: 40,
            child: Container(
              color: Colors.blue,
            ),
          ),
        ]));
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}
