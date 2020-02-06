import 'package:baindo/core/failures/failures.dart';
import 'package:baindo/features/manage_entries/domain/entities/entry.dart';
import 'package:baindo/features/manage_entries/domain/repositories/manage_entries_repository.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';

class ManageEntryOnRemoteSource{
  final ManageEntriesRepository repository;
  ManageEntryOnRemoteSource(this.repository);

  Future<Either<Failure, bool>> create(Entry entry){
    return repository.createEntry(twoDoTask: entry);
  }

  Future<Either<Failure, Entry>> read({@required String id}){
    return repository.readEntry(id: id);
  }

  Future<Either<Failure, bool>> update({@required Entry task, @required String id}){
    return repository.updateEntry(task: task, id: id);
  }

  Future<Either<Failure, bool>> delete({@required id}){
    return repository.deleteEntry(id: id);
  }
}
