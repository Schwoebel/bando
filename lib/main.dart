import 'package:baindo/core/features/authentication/injection_container.dart' as auth_di;
import 'package:baindo/core/features/authentication/presentation/pages/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:baindo/features/view_entries/injection_container.dart' as ve_di;
import 'package:baindo/features/manage_entries/injection_container.dart' as me_di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ve_di.init();
  me_di.init();
  auth_di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignIn(),
    );
  }
}
