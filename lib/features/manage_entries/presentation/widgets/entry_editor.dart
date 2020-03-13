import 'dart:convert';
import 'dart:io';

import 'package:baindo/features/manage_entries/data/models/entry_model.dart';
import 'package:baindo/features/manage_entries/domain/entities/entry.dart';
import 'package:baindo/features/manage_entries/presentation/bloc/add_entry/add_entry_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zefyr/zefyr.dart';
import 'package:quill_delta/quill_delta.dart';

class EntryEditor extends StatefulWidget {
  final Entry entry;

  EntryEditor({Key key, @required this.entry})
      : assert(entry != null),
        super(key: key);

  @override
  _EntryEditorState createState() => _EntryEditorState();
}

class _EntryEditorState extends State<EntryEditor> {
  ZefyrController _controller;

  FocusNode _focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final document = widget.entry.text.isEmpty
        ? NotusDocument()
        : NotusDocument.fromJson(jsonDecode(widget.entry.text));
    _controller = ZefyrController(document);
    _controller.addListener(() {
          BlocProvider.of<AddEntryBloc>(context).add(
            UpdateEntry(
              EntryModel(
                  createDate: widget.entry.createDate,
                  text: jsonEncode(
                    _controller.document.toJson(),
                  ),
                  title: '',
                  metaData: {'mood': widget.entry.metaData['mood']}),
            ),
          );
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
