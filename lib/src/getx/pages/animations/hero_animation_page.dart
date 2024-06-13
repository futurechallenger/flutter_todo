import 'package:flutter/material.dart';

class HeroAnimationPage extends StatefulWidget {
  const HeroAnimationPage({super.key});

  @override
  State<StatefulWidget> createState() => _HeroAnimationPageState();
}

class _HeroAnimationPageState extends State<HeroAnimationPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [Text("hero Animation")],
    );
  }
}
