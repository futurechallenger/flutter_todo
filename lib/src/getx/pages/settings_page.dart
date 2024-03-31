import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: const [
              ListTile(
                title: Text("Sort"),
              ),
              Divider(),
              ListTile(
                title: Text("Change Theme"),
              ),
              Divider(),
              ListTile(
                title: Text("Hide Completed Tasks"),
              )
            ],
          )),
    );
  }
}
