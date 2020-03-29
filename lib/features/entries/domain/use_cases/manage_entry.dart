import 'package:baindo/core/failures/failures.dart';
import 'package:baindo/core/use_cases/management_use_case.dart';
import 'package:baindo/core/use_cases/use_cases.dart';
import 'package:baindo/features/entries/domain/entities/entry.dart';
import 'package:baindo/features/entries/domain/repositories/manage_entries_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';

class ManageEntryOnRemoteSource extends ManagementUseCase<Entry, EntryParams> {
  final ManageEntriesRepository repository;

  ManageEntryOnRemoteSource({@required this.repository});

  Future<Either<Failure, bool>> create(EntryParams params) {
    return repository.createEntry(
        entry: params.entry, poiId: params.personOfInterestId);
  }

  Future<Either<Failure, Entry>> read(EntryParams params) {
    return repository.readEntry(id: params.entryId);
  }

  Future<Either<Failure, bool>> update(EntryParams params) {
    return repository.updateEntry(
        entry: params.entry,
        poiId: params.personOfInterestId,
        id: params.entryId);
  }

  Future<Either<Failure, bool>> delete(EntryParams params) {
    return repository.deleteEntry(
        id: params.entryId, poiId: params.personOfInterestId);
  }
}

class EntryParams extends Equatable {
  final Entry entry;
  final String personOfInterestId;
  final entryId;

  EntryParams({this.entryId, this.entry, @required this.personOfInterestId});

  @override
  // TODO: implement props
  List<Object> get props => [entry, personOfInterestId];
}
