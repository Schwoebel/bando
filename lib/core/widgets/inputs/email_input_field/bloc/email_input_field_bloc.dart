import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../email.validator.dart';

part 'email_input_field_event.dart';

part 'email_input_field_state.dart';

class EmailInputFieldBloc
    extends Bloc<EmailInputFieldEvent, EmailInputFieldState> {

  @override
  EmailInputFieldState get initialState => InitialInputFieldState();

  @override
  Future<void> close() {
    return super.close();
  }

  @override
  Stream<EmailInputFieldState> mapEventToState(
      EmailInputFieldEvent event) async* {
    if (event is ValueEntered) {
      yield HasValidValue(event.value);
    } else {
      yield InitialInputFieldState();
    }
  }
}
