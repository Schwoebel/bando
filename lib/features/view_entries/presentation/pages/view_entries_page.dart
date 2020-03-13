import 'package:baindo/core/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:baindo/features/view_entries/domain/entities/view_entry_arguments.dart';

import '../../../../features/manage_person_of_interest/presentation/bloc/person_of_interest/person_of_interest_bloc.dart';
import 'package:baindo/features/manage_entries/presentation/pages/add_entry_page.dart';
import 'package:baindo/features/view_entries/presentation/bloc/view_entries/view_entries_bloc.dart';
import 'package:baindo/features/view_entries/presentation/pages/entry_page.dart';
import 'package:baindo/features/view_entries/presentation/widgets/person_of_interest_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baindo/features/view_entries/injection_container.dart';

class ViewEntriesPage extends StatefulWidget {
  @override
  _ViewEntriesPageState createState() => _ViewEntriesPageState();
}

class _ViewEntriesPageState extends State<ViewEntriesPage> {
  String personOfInterestId;

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
              actions: <Widget>[],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEntryPage(
                      personOfInterest: personOfInterestId,
                    ),
                  ),
                );
              },
            ),
            body: SafeArea(
                child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  /* Expanded(
                    child: BlocListener<PersonOfInterestBloc,
                        PersonOfInterestState>(
                      listener: (BuildContext context,
                          PersonOfInterestState state) {},
                      child: BlocBuilder<PersonOfInterestBloc,
                          PersonOfInterestState>(
                        builder: (BuildContext context,
                            PersonOfInterestState state) {
                          if (state is InitialPersonOfInterestState) {
                            BlocProvider.of<PersonOfInterestBloc>(context)
                                .add(
                              ReadAllowedPersonsOfInterestEvent(),
                            );
                            return SizedBox();
                          } else if (state
                              is GetAllPersonsOfInterestComplete) {
                            return PersonOfInterestDropdown(
                              personsOfInterest: state.personsOfInterest,
                              callback: (String value) {
                                BlocProvider.of<ViewEntriesBloc>(context)
                                    .add(
                                  LoadEntriesEvent(
                                    value,
                                  ),
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                  ),*/
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
                                      ///TODO Sync personsOfInterest from firestore
                                      ///and store them in sharedPreferences so this can look it up locally.
                                      Expanded(
                                        child: Text(
                                          state.entries[i].prettyDate,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),

                                      ///TODO Sync moods from Firestore and store them
                                      /// in shared preferences so this can look them up locally through the MoodsBloc
                                      Expanded(
                                        child: Text(
                                          state.entries[i].title,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
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
            )),
          )),
    );
  }
}
