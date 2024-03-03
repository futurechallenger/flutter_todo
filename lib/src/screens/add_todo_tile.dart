import 'package:flutter/material.dart';
import 'package:flutter_todo/src/screens/sample_item.dart';

class AddTodoTile extends StatefulWidget {
  const AddTodoTile({super.key, required this.addTodoCallback});

  final ValueSetter<SampleItem> addTodoCallback;

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
                child: isAddingNew
                    ? Center(
                        child: TextField(
                          focusNode: fn,
                          controller: todoTextController,
                          style: const TextStyle(color: Colors.white),
                          textInputAction: TextInputAction.go,
                          decoration: const InputDecoration(
                              hintText: "Add a task",
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none),
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          debugPrint("+ Add button is clicked");
                          setState(() {
                            isAddingNew = true;
                          });
                        },
                        child: const Text("Add a Task",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20))),
              )),
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

//        widget.addTodoCallback(SampleItem(SAMPLE_ITEM_ID_COUNTER++));
        todoTextController.clear();
      }
    });
  }

  @override
  void dispose() {
    todoTextController.dispose();
    super.dispose();
  }
}
