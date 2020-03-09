import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_details_event.dart';

part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  @override
  UserDetailsState get initialState => InitialUserDetailsState();

  @override
  Stream<UserDetailsState> mapEventToState(UserDetailsEvent event) async* {
    // TODO: Add your event logic
  }
}
