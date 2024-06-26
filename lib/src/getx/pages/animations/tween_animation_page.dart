import 'package:flutter/material.dart';

class TweenAnimationPage extends StatefulWidget {
  const TweenAnimationPage({super.key});

  @override
  State<StatefulWidget> createState() => _TweenAnimationPageState();
}

class _TweenAnimationPageState extends State<TweenAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    final curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);

    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });

    _colorAnimation = ColorTween(begin: Colors.white, end: Colors.orange)
        .animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });

    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tween Animation"),
      ),
      body: Center(
        child: Opacity(
            opacity: _animation.value,
            child: Text(
              "Tween Animation",
              style: TextStyle(color: _colorAnimation.value, fontSize: 25),
            )),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
