import 'dart:math';

import 'package:flutter/material.dart';

double randomBorderRadius() {
  return Random().nextDouble() * 64;
}

double randomMargin() {
  return Random().nextDouble() * 64;
}

Color randomColor() {
  return Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
}

class ImplicitAnimationPage extends StatefulWidget {
  const ImplicitAnimationPage({super.key});

  @override
  State<StatefulWidget> createState() => _ImplicitAnimationPageState();
}

class _ImplicitAnimationPageState extends State<ImplicitAnimationPage> {
  double opacity = 0;
  //
  Color color = Colors.white;
  double radius = 0;
  double margin = 0;

  @override
  void initState() {
    super.initState();

    color = randomColor();
    radius = randomBorderRadius();
    margin = randomMargin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Implicit Animation"),
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  opacity = 1;
                });
              },
              child: const Text("Start 1")),
          TextButton(
              onPressed: () {
                setState(() {
                  color = randomColor();
                  radius = randomBorderRadius();
                  margin = randomMargin();
                });
              },
              child: const Text("Start 2"))
        ],
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.center,
              child: AnimatedOpacity(
                duration: const Duration(seconds: 2),
                opacity: opacity,
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    margin: EdgeInsets.all(margin),
                    decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(radius)),
                    child: const Text(
                      "Implicit Animation",
                      style: TextStyle(fontSize: 30),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
