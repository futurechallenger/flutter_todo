import 'package:flutter/material.dart';

Stream<int> countStream(int to) async* {
  for (int i = 1; i <= to; i++) {
    await Future.delayed(const Duration(seconds: 1));
    yield i;
  }
}

class StreamPage extends StatefulWidget {
  const StreamPage({super.key});

  @override
  State<StatefulWidget> createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  final _countStream = countStream(100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("STREAM"),
        ),
        body: StreamBuilder(
            stream: _countStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("error ${snapshot.error}"),
                );
              } else {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Center(
                      child: Text("None"),
                    );
                  case ConnectionState.waiting:
                    return const Center(
                      child: Text("Waiting..."),
                    );
                  case ConnectionState.active:
                    return Center(
                      child: Text("Active: ${snapshot.data}"),
                    );
                  case ConnectionState.done:
                    return Center(
                      child: Text("Active: ${snapshot.data}"),
                    );
                }
              }
            }));
  }
}
