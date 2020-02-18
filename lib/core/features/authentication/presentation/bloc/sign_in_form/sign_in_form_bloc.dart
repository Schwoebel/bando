import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sign_in_form_event.dart';

part 'sign_in_form_state.dart';

class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  @override
  SignInFormState get initialState => InitialSignInFormState();

  String _password, _email;

  @override
  Stream<SignInFormState> mapEventToState(SignInFormEvent event) async* {
    if (event is AddPasswordData) {
      _password = event.password;
      if (_password != null && _email != null) {
        yield CanSignIn(email: _email, password: _password);
      } else {
        yield InitialSignInFormState();
      }
    } else if (event is AddEmailData) {
      _email = event.email;
      if (_password != null && _email != null) {
        yield CanSignIn(email: _email, password: _password);
      } else {
        yield InitialSignInFormState();
      }
    }
  }

  Stream<SignInFormState> hasValidFormOfCredentials() async* {
    if (_password != null && _email != null) {
      yield CanSignIn(email: _email, password: _password);
    } else {
      yield InitialSignInFormState();
    }
  }
}
