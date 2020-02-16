import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'input_field_event.dart';

part 'input_field_state.dart';

class InputFieldBloc extends Bloc<InputFieldEvent, InputFieldState> {
  @override
  InputFieldState get initialState => InitialInputFieldState();

  @override
  Stream<InputFieldState> mapEventToState(InputFieldEvent event) async* {
    if(event is ValueEntered){
      yield HasValue(text: event.value);
    } else {
      yield InitialInputFieldState();
    }
  }
}
