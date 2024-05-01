import 'package:flutter/material.dart';

class ResponsivePage extends StatelessWidget {
  const ResponsivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Responsive Layout"),
      ),
      body: AspectRatio(
        aspectRatio: 3 / 2,
        child: Container(
          color: Colors.amber,
          child: const Center(
            child: FlutterLogo(
              size: 100,
            ),
          ),
        ),
      ), /*LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 480) {
          return Row(
            children: [
              Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: const [
                    ListTile(title: Text('Menu Item 1')),
                    ListTile(title: Text('Menu Item 2')),
                    ListTile(title: Text('Menu Item 3')),
                  ],
                ),
              ),
              const Expanded(
                child: Center(
                  child: Text('Content Area'),
                ),
              ),
            ],
          );
        } else {
          return ListView(
            children: const [
              ListTile(title: Text('Menu Item 1')),
              ListTile(title: Text('Menu Item 2')),
              ListTile(title: Text('Menu Item 3')),
            ],
          );
        }
      }),*/ /*Container(
        color: Colors.pinkAccent,
        child: Center(
          child: Container(
            color: Colors.yellow,
            height: height / 2, // half of the screen height size
            width: width / 2, // half of the screen width size
          ),
        ),
      ),*/
      /*Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.yellowAccent,
              )),
          Expanded(
              flex: 2,
              child: Container(
                color: Colors.orangeAccent,
              )),
          Expanded(
              flex: 4,
              child: Container(
                color: Colors.pinkAccent,
              )),
        ],
      ),*/
    );
  }
}
