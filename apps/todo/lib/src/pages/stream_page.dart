import 'dart:async';

import 'package:flutter/material.dart';

Stream<int> countStream(int to) async* {
  for (int i = 1; i <= to; i++) {
    await Future.delayed(const Duration(seconds: 1));
    yield i;
  }
}

Future<Stream<int>> countStreamWithController(int to) async {
  final controller = StreamController<int>.broadcast();

  for (int i = 1; i <= to; i++) {
    await Future.delayed(const Duration(seconds: 1));
    controller.add(i);
  }

  return controller.stream;
}

class StreamPage extends StatefulWidget {
  StreamPage({super.key});

  final controller = StreamController<int>.broadcast();
  // final controller = StreamController<int>();

  @override
  State<StatefulWidget> createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  final _countStream = countStream(100);
  Stream<int>? _countStream2;

  @override
  void initState() {
    // code here

    super.initState();
  }

  @override
  void dispose() {
    widget.controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("STREAM"),
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  if (mounted) {
                    setState(() {
                      _countStream2 = widget.controller.stream;
                    });
                  }

                  for (int i = 1; i <= 10; i++) {
                    await Future.delayed(const Duration(seconds: 1));
                    if (i == 5) {
                      // widget.controller.addError('Error with num $i');
                      throw Exception("Number is $i");
                    } else {
                      widget.controller.add(i);
                    }
                  }
                },
                child: const Text("Start stream")),
            Row(
              children: [
                Expanded(
                  child: StreamBuilder(
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
                      }),
                ),
                Expanded(
                  child: StreamBuilder(
                      stream: _countStream2,
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
                      }),
                ),
                // Expanded(
                //   child: StreamBuilder(
                //       stream: _countStream2,
                //       builder: (context, snapshot) {
                //         if (snapshot.hasError) {
                //           return Center(
                //             child: Text("error ${snapshot.error}"),
                //           );
                //         } else {
                //           switch (snapshot.connectionState) {
                //             case ConnectionState.none:
                //               return const Center(
                //                 child: Text("None"),
                //               );
                //             case ConnectionState.waiting:
                //               return const Center(
                //                 child: Text("Waiting..."),
                //               );
                //             case ConnectionState.active:
                //               return Center(
                //                 child: Text("Active: ${snapshot.data}"),
                //               );
                //             case ConnectionState.done:
                //               return Center(
                //                 child: Text("Active: ${snapshot.data}"),
                //               );
                //           }
                //         }
                //       }),
                // ),
              ],
            ),
          ],
        ));
  }
}
