import 'dart:convert';

import 'package:bando/features/entries/domain/entities/entry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zefyr/zefyr.dart';

class FormattedEntryViewer extends StatelessWidget {
  NotusDocument document;
  final Entry entry;
  bool documentLoaded;

  FormattedEntryViewer({Key key, this.entry}) {
    documentLoaded = _tryLoadingDocument();
  }

  _tryLoadingDocument() {
    try {
      document = NotusDocument.fromJson(jsonDecode(entry.text));
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
        constraints: BoxConstraints.expand(),
        child: documentLoaded
            ? ZefyrView(document: document)
            : Text(entry.text));
  }
}
