import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'person_of_interest_event.dart';

part 'person_of_interest_state.dart';

class PersonOfInterestBloc
  extends Bloc<PersonOfInterestEvent, PersonOfInterestState> {
  @override
  PersonOfInterestState get initialState => InitialPersonOfInterestState();

  @override
  Stream<PersonOfInterestState> mapEventToState(
    PersonOfInterestEvent event) async* {
    // TODO: Add your event logic
  }
}
