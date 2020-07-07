import 'dart:async';
import 'package:bando/features/entries/domain/use_cases/manage_entry.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'delete_entry_event.dart';

part 'delete_entry_state.dart';

class DeleteEntryBloc extends Bloc<DeleteEntryEvent, DeleteEntryState> {
  final ManageEntryOnRemoteSource manageEntry;

  DeleteEntryBloc(this.manageEntry) : super(InitialDeleteEntryState());

  @override
  Stream<DeleteEntryState> mapEventToState(DeleteEntryEvent event) async* {
    if (event is Delete) {
      await manageEntry.delete(EntryParams(
        personOfInterestId: event.poiID,
        entryId: event.entryID,
      ));
    }
  }
}
