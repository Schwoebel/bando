import 'dart:async';
import 'package:bando/core/failures/failures.dart';
import 'package:bando/features/entries/domain/entities/entry.dart';
import 'package:bando/features/entries/domain/use_cases/manage_entry.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'add_entry_event.dart';

part 'add_entry_state.dart';

class AddEntryBloc extends Bloc<AddEntryEvent, AddEntryState> {
  final ManageEntryOnRemoteSource manageEntryOnRemoteSource;

  AddEntryBloc({@required this.manageEntryOnRemoteSource});

  @override
  AddEntryState get initialState => InitialAddEntryState();

  @override
  Stream<AddEntryState> mapEventToState(AddEntryEvent event) async* {
    if (event is CreateEntry || event is UpdateEntry) {
      yield HasEntryInProgress(event.entry);
    } else if (event is SaveEntry) {
      yield SubmittingNewEntry();
      Either<Failure, bool> result =
          await manageEntryOnRemoteSource.create(EntryParams(
        entry: event.entry,
        personOfInterestId: event.personOfInterestId,
      ));
      yield* _eitherSavedOrFailure(result);
    }
  }

  Stream<AddEntryState> _eitherSavedOrFailure(Either<Failure, bool> result) async* {
    yield result.fold(
      (failure) => ErrorSubmittingEntry(),
      (success) => NewEntrySubmittedSuccessfully(),
    );
  }
}
