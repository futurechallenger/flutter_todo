import 'package:flutter/material.dart';
import 'package:flutter_todo/src/common/http_request.dart';
import 'package:flutter_todo/src/models/todo_model.dart';

import 'item_details_view.dart';

/// Displays a list of SampleItems.
class ItemListView extends StatefulWidget {
  const ItemListView({super.key});

  static const routeName = '/';

  @override
  State<ItemListView> createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  late Future<List<TodoItem>?> items;

  @override
  void initState() {
    super.initState();

    items = HttpRequest().fetchTodoList('uncompleted');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TodoItem>?>(
        future: items,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              restorationId: 'sampleItemListView',
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                final item = snapshot.data![index];

                return ListTile(
                    title: Text(item.content),
                    leading: const Icon(Icons.circle_outlined),
                    onTap: () {
                      Navigator.restorablePushNamed(
                        context,
                        ItemDetailsView.routeName,
                      );
                    });
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const CircularProgressIndicator();
        });
  }
}
