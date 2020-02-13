import 'dart:async';
import 'package:baindo/features/manage_entries/domain/entities/entry.dart';
import 'package:baindo/features/manage_entries/domain/entities/mood.dart';
import 'package:baindo/features/manage_entries/domain/use_cases/manage_entry.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_entry_event.dart';

part 'create_entry_state.dart';

class CreateEntryBloc extends Bloc<CreateEntryEvent, CreateEntryState> {
  final ManageEntryOnRemoteSource manageEntryOnRemoteSource;

  CreateEntryBloc({@required this.manageEntryOnRemoteSource});

  @override
  CreateEntryState get initialState => InitialCreateEntryState();

  @override
  Stream<CreateEntryState> mapEventToState(CreateEntryEvent event) async* {
    if (event is InitializeEntryEvent) {
    } else if (event is SaveEntryOnRemoteEvent) {
    } else if (event is CreateEntry) {
    } else if (event is UpdateEntry) {
    } else {}
  }
}
