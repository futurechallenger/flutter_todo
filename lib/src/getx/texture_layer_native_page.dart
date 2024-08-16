import 'package:flutter/material.dart';
import 'package:flutter_todo/src/common/native_texture_layer_view.dart';

class TextureLayerNativePage extends StatelessWidget {
  const TextureLayerNativePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Texture Layer"),
      ),
      body: const Center(child: NativeTextureLayerView()),
    );
  }
}
