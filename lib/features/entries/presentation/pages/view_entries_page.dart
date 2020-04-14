import 'package:animations/animations.dart';
import 'package:bando/features/entries/domain/entities/entry.dart';
import 'package:bando/features/entries/domain/entities/view_entry_arguments.dart';

import '../../../manage_person_of_interest/presentation/bloc/person_of_interest/person_of_interest_bloc.dart';
import 'package:bando/features/entries/presentation/pages/add_entry_page.dart';
import 'package:bando/features/entries/presentation/bloc/view_entries/view_entries_bloc.dart';
import 'package:bando/features/entries/presentation/pages/entry_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bando/features/entries/injection_container.dart';

const double _fabDimension = 56.0;

class ViewEntriesPage extends StatefulWidget {
  @override
  _ViewEntriesPageState createState() => _ViewEntriesPageState();
}

class _ViewEntriesPageState extends State<ViewEntriesPage> {
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  String personOfInterestId;
  List<Entry> entries;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final ViewEntriesArgs args = ModalRoute.of(context).settings.arguments;
    personOfInterestId = args.id;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ViewEntriesBloc>(
          create: (BuildContext context) => sl<ViewEntriesBloc>(),
        ),
        BlocProvider<PersonOfInterestBloc>(
          create: (BuildContext context) => sl<PersonOfInterestBloc>(),
        )
      ],
      child: BlocListener<PersonOfInterestBloc, PersonOfInterestState>(
        listener: (BuildContext context, PersonOfInterestState state) {
          if (state is InitialPersonOfInterestState) {
            BlocProvider.of<PersonOfInterestBloc>(context).add(
              ReadAllowedPersonsOfInterestEvent(),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: null,
            title: Text("Jounal Entries"),
            actions: <Widget>[],
          ),
          floatingActionButton: OpenContainer(
            closedColor: Theme.of(context).colorScheme.secondary,
            closedShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(_fabDimension / 2),
              ),
            ),
            closedBuilder: (BuildContext context, VoidCallback openContainer) {
              return SizedBox(
                height: _fabDimension,
                width: _fabDimension,
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              );
            },
            openBuilder: (BuildContext c, VoidCallback action) => AddEntryPage(
              personOfInterest: personOfInterestId,
            ),
            tappable: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  BlocBuilder<ViewEntriesBloc, ViewEntriesState>(
                    builder: (BuildContext context, ViewEntriesState state) {
                      if (state is ViewEntriesEmptyState) {
                        BlocProvider.of<ViewEntriesBloc>(context).add(
                          LoadEntriesEvent(
                            personOfInterestId,
                          ),
                        );
                        return Text('Välkommen');
                      } else if (state is ViewEntriesLoadingState) {
                        return CircularProgressIndicator();
                      } else if (state is ViewEntriesHasError) {
                        return Text(state.message);
                      } else if (state is ViewEntriesSuccessState) {
                        personOfInterestId = state.personOfInterest;
                        return Expanded(
                          child: StreamBuilder<List<Entry>>(
                            stream: state.entries,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                entries = snapshot.data;
                                return ListView.builder(
                                  itemCount: entries.length,
                                  itemBuilder: (BuildContext context, int i) {
                                    return Card(
                                      child: ListTile(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EntryPage(
                                              entry: entries[i],
                                            ),
                                          ),
                                        ),
                                        leading: Icon(
                                          Icons.school,
                                          size: 32.0,
                                        ),
                                        title: Text(
                                         entries[i].title ?? '',
                                        ),
                                        subtitle: Text(
                                          entries[i].prettyDate,
                                        ),
                                        trailing: DropdownButton<String>(
                                          underline: SizedBox(),
                                          onChanged: (String value) {
                                            if (value == 'Delete') {
                                              Scaffold.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'Not available, yet.'),
                                                ),
                                              );
                                            }
                                          },
                                          items: [
                                            DropdownMenuItem(
                                              value: 'Delete',
                                              child: Text('Delete'),
                                            )
                                          ],
                                          icon: Icon(Icons.more_vert),
                                        ),
                                        isThreeLine: true,
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return SizedBox();
                              }
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
          ),
        ),
      ),
    );
  }
}
