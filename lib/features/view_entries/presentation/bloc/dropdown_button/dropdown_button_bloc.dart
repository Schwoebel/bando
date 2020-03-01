import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'dropdown_button_event.dart';

part 'dropdown_button_state.dart';

class DropdownButtonBloc
  extends Bloc<DropdownButtonEvent, DropdownButtonState> {
  @override
  DropdownButtonState get initialState => InitialDropdownButtonState();

  @override
  Stream<DropdownButtonState> mapEventToState(
    DropdownButtonEvent event) async* {
    if(event is ChangeValueEvent){
      yield ValueChangedState(event.newValue);
    }
  }
}
