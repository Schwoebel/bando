import 'package:baindo/features/manage_entries/domain/entities/entry.dart';
import 'package:baindo/features/view_entries/presentation/widgets/formatted_entry_viewer.dart';
import 'package:flutter/material.dart';

class EntryPage extends StatelessWidget {
  final Entry entry;

  EntryPage({@required this.entry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(''),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(entry.prettyDate),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(child: FormattedEntryViewer(entry: entry)),
              ],
            ),
          ),
        ));
  }
}
