import 'package:flutter/material.dart';

class TextInputSwitchView extends StatefulWidget {
  const TextInputSwitchView({
    super.key,
    this.content = "",
    required this.inputDecoration,
    required this.textStyle,
    required this.addTodoCallback,
  });

  final String content;
  final InputDecoration inputDecoration;
  final TextStyle textStyle;

  final ValueSetter<String> addTodoCallback;

  @override
  State<TextInputSwitchView> createState() => _TextInputSwitchViewState();
}

class _TextInputSwitchViewState extends State<TextInputSwitchView> {
  bool _isAddingNew = false;
  bool _isEditing = false;
  String _hintText = "";
  final TextEditingController _controller = TextEditingController();
  final FocusNode _fn = FocusNode();

  @override
  Widget build(BuildContext context) {
    if (_isAddingNew) {
      return Center(
          child: TextField(
        focusNode: _fn,
        controller: _controller,
        style: widget.textStyle,
        textInputAction: TextInputAction.go,
        decoration: InputDecoration(
            hintText: _hintText,
            border: InputBorder.none,
            hintStyle: widget.textStyle),
      ));
    } else {
      return TextButton(
          onPressed: () {
            debugPrint("+ Add button is clicked");
            setState(() {
              _isAddingNew = true;
            });
            _fn.requestFocus();
          },
          child: Row(
            children: [
              Text(_hintText, style: widget.textStyle),
              const Expanded(flex: 1, child: Spacer())
            ],
          ));
    }
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      _hintText = widget.content;
    });
    _controller.text = widget.content;

    _controller.addListener(() {
      setState(() {
        _isEditing = true;
      });
    });

    _fn.addListener(() {
      debugPrint('focus node has focus: ${_fn.hasFocus}');
      if (!_fn.hasFocus) {
        setState(() {
          _isAddingNew = false;
          _isEditing = false;
        });

        if (_controller.text.isNotEmpty) {
          widget.addTodoCallback(_controller.text);
        }

        setState(() {
          _hintText = _controller.text;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _fn.dispose();
    super.dispose();
  }
}
