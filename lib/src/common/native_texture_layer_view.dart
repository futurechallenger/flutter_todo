import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeTextureLayerView extends StatelessWidget {
  const NativeTextureLayerView({super.key});

  @override
  Widget build(BuildContext context) {
    const String viewType = "@views/native_example_view";
    final Map<String, dynamic> creationParams = <String, dynamic>{};

    return AndroidView(
        viewType: viewType,
        layoutDirection: TextDirection.ltr,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec());
  }
}
