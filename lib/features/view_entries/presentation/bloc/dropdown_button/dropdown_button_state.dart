part of 'dropdown_button_bloc.dart';

@immutable
abstract class DropdownButtonState extends Equatable {}

class InitialDropdownButtonState extends DropdownButtonState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ValueChangedState extends DropdownButtonState {
  final dynamic newValue;

  ValueChangedState(this.newValue);

  @override
  // TODO: implement props
  List<Object> get props => [newValue];
}
