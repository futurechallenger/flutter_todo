import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_todo/src/models/todo_model.dart';

class HeroAnimationPage extends StatefulWidget {
  const HeroAnimationPage({super.key, required this.todoItem});

  final TodoItem todoItem;

  @override
  State<StatefulWidget> createState() => _HeroAnimationPageState();
}

class _HeroAnimationPageState extends State<HeroAnimationPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: only for test
    timeDilation = 3.0;

    final content = widget.todoItem.content;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        leading: PopScope(
          onPopInvoked: (didPop) {
            debugPrint('detail page pop');
          },
          child: BackButton(
            onPressed: () {
              Navigator.pop(context, "refresh");
            },
          ),
        ),
      ),
      body: Hero(
        tag: content,
        child: Center(
          child: Text(
            content,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ),
    );
  }
}
