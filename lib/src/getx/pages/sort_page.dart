import 'package:flutter/material.dart';

class SortPage extends StatelessWidget {
  const SortPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sort by"),
      ),
      body: const SingleChildScrollView(
        child: ListBody(
          children: [
            ListTile(title: Text("Create Date")),
            ListTile(title: Text("Due Date")),
          ],
        ),
      ),
    );
  }
}
