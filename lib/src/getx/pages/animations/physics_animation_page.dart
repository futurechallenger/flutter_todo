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
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..addListener(() {
            setState(() {});
          });

    _animation = Tween<double>(begin: 0, end: 400).animate(
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Physics Animation"),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Stack(
              children: [
                Positioned(
                  left: 70,
                  top: _animation.value,
                  child: child!,
                )
              ],
            );
          },
          child: GestureDetector(
            onTap: () {
              _startAnimation();
            },
            child: Container(
              height: 100,
              width: 250,
              decoration: BoxDecoration(
                color: const Color(0xFF00EF3C),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                  child: Text(
                'SEMAPHORE',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              )),
            ),
          ),
        ),
      ),
    );
  }

  void _startAnimation() {
    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}
