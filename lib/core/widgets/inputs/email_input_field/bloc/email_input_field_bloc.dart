import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../email.validator.dart';

part 'email_input_field_event.dart';

part 'email_input_field_state.dart';

class EmailInputFieldBloc
    extends Bloc<EmailInputFieldEvent, EmailInputFieldState>
    with EmailValidator {
  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();

  Function(String) get onEmailChanged => _emailController.sink.add;

  Stream<String> get email => _emailController.stream.transform(validateEmail);

  bool isValid = false;

  EmailInputFieldBloc() {
    email.listen((value) {
      isValid = true;
    }, onError: (error) {
      isValid = false;
    });
  }

  @override
  EmailInputFieldState get initialState => InitialInputFieldState();

  @override
  Future<void> close() {
    _emailController.close();
    return super.close();
  }

  @override
  Stream<EmailInputFieldState> mapEventToState(
      EmailInputFieldEvent event) async* {
    if (event is ValueEntered) {
      onEmailChanged(event.value);
      yield isValid ? HasValidValue() : HasError();
    } else {
      yield InitialInputFieldState();
    }
  }
}
