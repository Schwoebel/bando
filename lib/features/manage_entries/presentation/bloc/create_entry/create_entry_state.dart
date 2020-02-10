part of 'create_entry_bloc.dart';

@immutable
abstract class CreateEntryState {}

class InitialCreateEntryState extends CreateEntryState {}

class SavingEntryState extends CreateEntryState {}

class EntryCreatedState extends CreateEntryState {}

class EntryInProgress extends CreateEntryState {
  final Entry entry;

  EntryInProgress({@required this.entry});
}
