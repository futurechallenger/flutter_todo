import 'package:flutter/material.dart';
import 'package:flutter_todo/src/common/native_example_view.dart';

class NativeViewPage extends StatelessWidget {
  const NativeViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Hybrid Composition"),
        ),
        body: Center(
            child: Container(
                color: Colors.amber,
                child:
                    const SizedBox(width: 300, child: NativeExampleView()))));
  }
}
