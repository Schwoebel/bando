import 'package:bando/core/features/user_details/presentation/bloc/author/author_bloc.dart';
import 'package:bando/core/features/user_details/presentation/bloc/user_details/user_details_bloc.dart';
import 'package:bando/core/features/user_details/presentation/widgets/author_drop_down.dart';
import 'package:bando/features/entries/data/models/entry_model.dart';
import 'package:bando/features/entries/domain/entities/entry.dart';
import 'package:bando/features/entries/presentation/bloc/add_entry/add_entry_bloc.dart';
import 'package:bando/features/entries/presentation/widgets/entry_editor.dart';
import 'package:bando/core/features/mood/presentation/bloc/mood/mood_bloc.dart';
import 'package:bando/core/features/mood/presentation/widgets/mood_dropdown.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection_container.dart';

class AddEntryPage extends StatefulWidget {
  final String personOfInterest;

  AddEntryPage({Key key, @required this.personOfInterest}) : super(key: key);

  @override
  _AddEntryPageState createState() => _AddEntryPageState();
}

class _AddEntryPageState extends State<AddEntryPage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String title;
  String text;
  String mood;
  String author;
  int createTime;
  TextEditingController _titleController;

  @override
  void initState() {
    _titleController = TextEditingController()..addListener(_onChanged);
    createTime = DateTime.now().millisecondsSinceEpoch;
    super.initState();
  }

  void _onChanged() {
    title = _titleController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Entry'),
      ),
      resizeToAvoidBottomPadding: false,
      body: MultiBlocProvider(
        providers: [
          BlocProvider<AddEntryBloc>(
            create: (_) => sl<AddEntryBloc>(),
          ),
          BlocProvider<UserDetailsBloc>(
            create: (_) => sl<UserDetailsBloc>()..add(GetUserDetailsEvent()),
          ),
          BlocProvider<MoodBloc>(
            create: (_) => sl<MoodBloc>()
              ..add(
                GetMoodsEvent(),
              ),
          ),
          BlocProvider<AuthorBloc>(
            create: (_) => sl<AuthorBloc>()
              ..add(
                GetAuthors(),
              ),
          )
        ],
        child: BlocListener<AddEntryBloc, AddEntryState>(
          listener: (BuildContext context, AddEntryState state) {
            if (state is NewEntrySubmittedSuccessfully) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Entry Added'),
                ),
              );
              //Navigator.pop(context);
            } else if (state is SubmittingNewEntry) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Adding Entry'),
                ),
              );
              // Navigator.pop(context);
            } else if (state is ErrorSubmittingEntry) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error saving Entry, please try again later'),
                ),
              );
            }
          },
          child: BlocBuilder<AddEntryBloc, AddEntryState>(
            builder: (BuildContext context, AddEntryState addEntryState) {
              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                validator: (String value) =>
                                    title == null || title.isEmpty
                                        ? null
                                        : title,
                                decoration: InputDecoration(
                                  labelText: 'Title',
                                ),
                                controller: _titleController,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4.0, color: Colors.greenAccent),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            constraints: BoxConstraints.expand(),
                            child: EntryEditor(
                              value: '',
                              onUpdated: (String value) {
                                text = value;
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: MoodDropdown(
                                onSelected: (String value) {
                                  mood = value;
                                },
                              ),
                            ),
                            Expanded(
                              child: AuthorDropDown(
                                onSelected: (String value) {
                                  author = value;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          constraints: BoxConstraints(
                            minWidth: 50,
                            maxWidth: 100,
                          ),
                          child: ButtonTheme(
                            minWidth: 300,
                            height: 50,
                            child: RaisedButton(
                              color: Color(0xFFc2e59c),
                              onPressed: () => _triggerSave(context),
                              child: Text('Submit'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _triggerSave(BuildContext context) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    BlocProvider.of<AddEntryBloc>(context).add(
      SaveEntry(
          EntryModel(
            authorId: user.uid,
            createDate: createTime,
            title: title ?? '',
            text: text ?? '',
            author: author ?? '',
            metaData: {
              'mood': mood ?? '',
            },
          ),
          widget.personOfInterest),
    );
  }
}
