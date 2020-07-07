
import 'package:bando/features/entries/presentation/pages/view_entries_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bando/features/authentication/injection_container.dart';
import 'package:bando/features/authentication/presentation/bloc/auth/auth_bloc.dart';

class CreateUser extends StatefulWidget {
  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  AuthBloc authBloc;
  String _email = "";
  String _password = "";

  @override
  void initState() {
    authBloc = sl<AuthBloc>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        bloc: authBloc,
        builder: (context, AuthState state) {
          if (state is Loading) {
            return Container(
              child: Center(
                child: Text('State Loading'),
              ),
            );
          } else if (state is Loaded || state is Empty) {
            if (state is Loaded && state.auth.currentUser != null) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ViewEntriesPage()));
              return SizedBox();
            } else {
              return Scaffold(
                body: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Color(0xFFc2e59c),
                        Color(0xFF64b3f4),
                      ],
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Image.network(
                            "http://placehold.it/250x150/bando.png?text=bando"),
                      ),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Form(
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(),
                                  ),
                                  //
                                ),
                                onChanged: (value) {
                                  _email = value;
                                  print(_email);
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) return "you're empty bro";
                                  return null;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(),
                                  ),
                                  //
                                ),
                                onChanged: (value) {
                                  print(_password);
                                  _password = value;
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text('Create User')),
                                color: Color(0xFF10b3e5),
                                textColor: Colors.white,
                                onPressed: () {
                                  if (_email.isEmpty || _password.isEmpty) {
                                    print('empty');
                                    return null;
                                  } else {
                                    print('test');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ViewEntriesPage(),
                                      ),
                                    );
                                    /*authBloc.add(
                                      CreateUserEvent(
                                        email: _email,
                                        password: _password,
                                      ),
                                    );*/
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              );
            }
          } else {
            return Container(
              child: Center(
                child: Text('AuthState Error'),
              ),
            );
          }
        });
  }


  @override
  void dispose() {
    authBloc.close();

    super.dispose();
  }
}
