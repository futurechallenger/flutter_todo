import 'package:flutter/material.dart';

class SortPage extends StatelessWidget {
  const SortPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Column(
        children: [
          Expanded(
            child: Container(
              // height: double.infinity,
              // width: double.infinity,
              color: Colors.amber,
              child: const Text("Sort by..."),
            ),
          ),
        ],
      ),
    );
  }
}
