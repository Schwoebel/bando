import 'package:bando/core/failures/failures.dart';
import 'package:bando/core/use_cases/management_use_case.dart';
import 'package:bando/core/use_cases/use_cases.dart';
import 'package:bando/features/entries/domain/entities/entry.dart';
import 'package:bando/features/entries/domain/repositories/manage_entries_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';

class ManageEntryOnRemoteSource extends ManagementUseCase<Entry, EntryParams> {
  final ManageEntriesRepository repository;

  ManageEntryOnRemoteSource({@required this.repository});

  Future<Either<Failure, bool>> create(CreateParams params) {
    return repository.createEntry(
        entry: params.entry, poiId: params.personOfInterestId);
  }

  Future<Either<Failure, Entry>> read(ReadParams params) {
    return repository.readEntry(id: params.objectId);
  }

  Future<Either<Failure, bool>> update(UpdateParams params) {
    return repository.updateEntry(
        entry: params.entry,
        poiId: params.personOfInterestId,
        id: params.entryId);
  }

  Future<Either<Failure, bool>> delete(DeleteParams params) {
    return repository.deleteEntry(
        id: params.entryId, poiId: params.personOfInterestId);
  }

  @override
  Future<Either<Failure, List<Entry>>> readAll() {
    // TODO: implement readAll
    throw UnimplementedError();
  }
}
