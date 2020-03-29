part of 'add_entry_bloc.dart';

@immutable
abstract class AddEntryState {}

class InitialAddEntryState extends AddEntryState {}

class HasEntryInProgress extends AddEntryState{
  final Entry entry;

  HasEntryInProgress(this.entry);
}

class SubmittingNewEntry extends AddEntryState {

}

class NewEntrySubmittedSuccessfully extends AddEntryState {

}

class ErrorSubmittingEntry extends AddEntryState {

}
