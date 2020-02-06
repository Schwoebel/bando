import 'package:baindo/features/manage_entries/presentation/pages/add_entry_page.dart';
import 'package:baindo/features/view_entries/presentation/bloc/view_entries_bloc.dart';
import 'package:baindo/features/manage_entries/presentation/pages/entry_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baindo/features/view_entries/injection_container.dart';

class ViewEntriesPage extends StatefulWidget {
  @override
  _ViewEntriesPageState createState() => _ViewEntriesPageState();
}

class _ViewEntriesPageState extends State<ViewEntriesPage> {
  ViewEntriesBloc bloc;

  @override
  void initState() {
    bloc = sl<ViewEntriesBloc>();
    bloc.add(LoadEntriesEvent('NIBS-01'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AddEntryPage(personOfInterest: 'NIBS-01')),
          );
        },
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            BlocBuilder<ViewEntriesBloc, ViewEntriesState>(
              bloc: bloc,
              builder: (BuildContext context, ViewEntriesState state) {
                if (state is ViewEntriesEmptyState) {
                  return Text('Välkommen');
                } else if (state is ViewEntriesLoadingState) {
                  return CircularProgressIndicator();
                } else if (state is ViewEntriesHasError) {
                  return Text(state.message);
                } else if (state is ViewEntriesSuccessState) {
                  return Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 2,
                          thickness: 2,
                          color: Colors.black,
                        );
                      },
                      itemCount: state.entries.length,
                      itemBuilder: (BuildContext context, int i) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EntryPage(
                                  entry: state.entries[i],
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              children: <Widget>[
                                Text(state.entries[i].personOfInterest),
                                Text(state.entries[i].mood),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
