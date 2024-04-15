import 'package:flutter/material.dart';
import 'package:flutter_todo/src/getx/pages/sort_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              ListTile(
                title: const Text("Sort"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const SortPage()));
                },
              ),
              const Divider(),
              const ListTile(
                title: Text("Change Theme"),
              ),
              const Divider(),
              const ListTile(
                title: Text("Hide Completed Tasks"),
              )
            ],
          )),
    );
  }
}
