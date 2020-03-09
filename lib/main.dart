import 'package:baindo/core/features/user_profile/presentation/pages/user_details.dart';

import 'core/features/authentication/injection_container.dart' as auth_di;
import 'core/features/authentication/presentation/pages/sign_in.dart';
import 'package:flutter/material.dart';
import 'core/features/mood/presentation/bloc/mood/mood_bloc.dart';
import 'features/view_entries/injection_container.dart' as ve_di;
import 'features/manage_entries/injection_container.dart' as me_di;
import 'features/manage_person_of_interest/injection_container.dart' as pi_di;
import 'core/features/mood/injection_container.dart' as mood_di;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/features/authentication/injection_container.dart';
import 'core/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'features/manage_person_of_interest/presentation/bloc/person_of_interest/person_of_interest_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ve_di.init();
  me_di.init();
  auth_di.init();
  mood_di.init();
  pi_di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bando an app to connect all the parts in your child's upbringing",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (BuildContext context) => sl<AuthBloc>(),
          ),
          BlocProvider<MoodBloc>(
            create: (BuildContext context) => sl<MoodBloc>(),
          ),
          BlocProvider<PersonOfInterestBloc>(
            create: (BuildContext context) => sl<PersonOfInterestBloc>()
          ),
          BlocProvider<AuthBloc>(
            create: (BuildContext context) => sl<AuthBloc>()
          )
        ],
        child: SignIn(),
      ),
      routes: {
        '/profile': (BuildContext context) => UserDetailsPage(),
      },
    );
  }
}
