import 'package:bando/core/features/user_details/presentation/pages/edit_user_details_page.dart';
import 'package:bando/core/features/user_details/presentation/pages/user_details_portal_page.dart';
import 'package:bando/core/theme/bando_theme.dart';
import 'package:bando/features/manage_person_of_interest/presentation/pages/add_person_of_interest.dart';

import 'core/features/authentication/presentation/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'core/features/mood/presentation/bloc/mood/mood_bloc.dart';
import 'core/features/user_details/presentation/bloc/user_details/user_details_bloc.dart';
import 'features/manage_person_of_interest/presentation/pages/person_of_interest_page.dart';
import 'features/entries/presentation/pages/view_entries_page.dart';
import 'injection_container.dart' as app_di;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/features/authentication/injection_container.dart';
import 'core/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'features/manage_person_of_interest/presentation/bloc/person_of_interest/person_of_interest_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await app_di.init();
  runApp(Bando());
}

class Bando extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Bando an app to connect all the parts in your child's upbringing",
      theme: BandoThemeData,
      home: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (BuildContext context) => sl<AuthBloc>(),
            ),
            BlocProvider<MoodBloc>(
              create: (BuildContext context) => sl<MoodBloc>(),
            ),
            BlocProvider<PersonOfInterestBloc>(
                create: (BuildContext context) => sl<PersonOfInterestBloc>()),
            BlocProvider<UserDetailsBloc>(
              create: (BuildContext context) => sl<UserDetailsBloc>(),
            )
          ],
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (BuildContext context, AuthState state) {
              if (state is Empty) {
                BlocProvider.of<AuthBloc>(context).add(GetCurrentUserEvent());
              }
              if (state is Loaded && state.auth.currentUser != null) {
                BlocProvider.of<UserDetailsBloc>(context)
                    .add(GetUserDetailsEvent());
                return PersonOfInterestPage();
              } else {
                return SignIn();
              }
            },
          )),
      routes: {
        '/addPoi': (_) => AddPersonOfInterest(),
        '/userDetails': (BuildContext context) => UserDetailsPortalPage(),
        '/viewEntries': (BuildContext context) => ViewEntriesPage(),
        '/poi': (_) => PersonOfInterestPage()
      },
    );
  }
}
