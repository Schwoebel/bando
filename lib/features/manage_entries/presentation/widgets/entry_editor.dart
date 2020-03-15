import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zefyr/zefyr.dart';

class EntryEditor extends StatefulWidget {
  final String value;
  final Function(String) onUpdated;

  EntryEditor({Key key, this.value, @required this.onUpdated})
      : assert(onUpdated != null),
        super(key: key);

  @override
  _EntryEditorState createState() => _EntryEditorState();
}

class _EntryEditorState extends State<EntryEditor> {
  ZefyrController _controller;

  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    final document = widget.value.isEmpty
        ? NotusDocument()
        : NotusDocument.fromJson(jsonDecode(widget.value));
    _controller = ZefyrController(document);
    _controller.addListener(() {
      widget.onUpdated(jsonEncode(
        _controller.document.toJson(),
      ));
    });
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return ZefyrScaffold(
      child: ZefyrEditor(
        padding: EdgeInsets.all(16),
        controller: _controller,
        focusNode: _focusNode,
      ),
    );
  }
}
