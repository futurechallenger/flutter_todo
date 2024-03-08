import 'package:flutter/material.dart';
import 'package:flutter_todo/src/screens/widgets/text_input_switch_view.dart';

class AddTodoTile extends StatefulWidget {
  const AddTodoTile({super.key, required this.addTodoCallback});

  final ValueSetter<String> addTodoCallback;

  @override
  State<AddTodoTile> createState() => _AddTodoTileState();
}

class _AddTodoTileState extends State<AddTodoTile> {
  bool isAddingNew = false;
  bool isEditing = false;
  TextEditingController todoTextController = TextEditingController();
  FocusNode fn = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: IconButton(
                onPressed: () {
                  debugPrint("add icon button is clicked");
                  setState(() {
                    isAddingNew = true;
                  });
                },
                icon: isEditing
                    ? const Icon(
                        Icons.circle_outlined,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.add,
                        color: Colors.white,
                      )),
          ),
          Expanded(
              flex: 1,
              child: SizedBox(
                  height: 80,
                  child: TextInputSwitchView(
                    content: "Add a Task",
                    inputDecoration: const InputDecoration(
                        hintText: "Add a Task",
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none),
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 20),
                    addTodoCallback: widget.addTodoCallback,
                  ))),
          const SizedBox(
            width: 100,
            height: 80,
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    todoTextController.addListener(() {
      setState(() {
        isEditing = true;
      });
    });

    fn.addListener(() {
      debugPrint('focus node has focus: ${fn.hasFocus}');
      if (!fn.hasFocus) {
        setState(() {
          isAddingNew = false;
          isEditing = false;
        });

        widget.addTodoCallback(todoTextController.text);
      }
    });
  }

  @override
  void dispose() {
    todoTextController.dispose();
    super.dispose();
  }
}
