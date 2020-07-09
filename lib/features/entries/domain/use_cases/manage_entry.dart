import 'package:bando/core/failures/failures.dart';
import 'package:bando/core/use_cases/management_use_case.dart';
import 'package:bando/core/use_cases/use_cases.dart';
import 'package:bando/features/entries/domain/entities/entry.dart';
import 'package:bando/features/entries/domain/repositories/manage_entries_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';

class ManageEntryOnRemoteSource extends ManagementUseCase<Entry, CRUDParams> {
  final ManageEntriesRepository repository;

  ManageEntryOnRemoteSource({@required this.repository});

  Future<Either<Failure, Entry>> create(CreateParams<Entry> params) {
    return repository.createEntry(
        entry: params.objectToCreate, poiId: params.parentId);
  }

  Future<Either<Failure, Entry>> read(ReadParams params) {
    return repository.readEntry(id: params.objectId);
  }

  Future<Either<Failure, Entry>> update(UpdateParams<String, Entry> params) {
    return repository.updateEntry(
        entry: params.objectToUpdate,
        poiId: params.parentId,
        id: params.objectToUpdateId);
  }

  Future<Either<Failure, bool>> delete(DeleteParams<String> params) {
    return repository.deleteEntry(id: params.objectToDelete, poiId: params.parentId);
  }

  @override
  Future<Either<Failure, List<Entry>>> readAll() {
    // TODO: implement readAll
    throw UnimplementedError();
  }
}

class CreateEntryParams extends CreateParams<Entry> {
  final String personOfInterestId;

  CreateEntryParams(Entry objectToCreate, {@required this.personOfInterestId})
      : super(objectToCreate);

  @override
  List<Object> get props => [objectToCreate, personOfInterestId];

  @override
  bool get stringify => true;
}

class ReadEntryParams extends ReadParams<String> {
  ReadEntryParams(String entryId, String personOfInterestId)
      : super(entryId, parentId: personOfInterestId);

  @override
  List<Object> get props => [objectId, parentId];

  @override
  bool get stringify => true;
}

class UpdateEntryParams extends UpdateParams<String, Entry> {
  UpdateEntryParams(
      String objectToUpdateId, Entry objectToUpdate, String parentId)
      : super(objectToUpdateId, objectToUpdate, parentId: parentId);

  @override
  // TODO: implement props
  List<Object> get props => [objectToUpdateId, objectToUpdate];

  @override
  bool get stringify => true;
}

class DeleteEntryParams extends DeleteParams<String> {
  DeleteEntryParams(String objectToDelete, String parentId)
      : super(objectToDelete, parentId: parentId);

  @override
  List<Object> get props => [objectToDelete, parentId];

  @override
  bool get stringify => true;
}
