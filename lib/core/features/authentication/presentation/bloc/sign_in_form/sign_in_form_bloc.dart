import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sign_in_form_event.dart';

part 'sign_in_form_state.dart';

class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  @override
  SignInFormState get initialState => InitialSignInFormState();

  @override
  Stream<SignInFormState> mapEventToState(SignInFormEvent event) async* {
    // TODO: Add your event logic
  }
}
