import 'package:baindo/core/failures/failures.dart';
import 'package:baindo/features/manage_entries/data/data_sources/entry_remote_source.dart';
import 'package:baindo/features/manage_entries/data/models/entry_model.dart';
import 'package:baindo/features/manage_entries/domain/entities/entry.dart';
import 'package:baindo/features/manage_entries/domain/repositories/manage_entries_repository.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';

class ManageEntriesRepositoryImpl extends ManageEntriesRepository {
  final EntryRemoteSource entryRemoteSource;

  ManageEntriesRepositoryImpl({@required this.entryRemoteSource});

  @override
  Future<Either<Failure, bool>> createEntry({Entry entry, String poiId}) async {
    try{
      EntryModel model = EntryModel.fromEntry(entry);
      await entryRemoteSource.createEntry(entry: model);
      return Right(true);
    } catch(e){
      return Left(NetworkFailure());
    }
    return null;
  }

  @override
  Future<Either<Failure, bool>> deleteEntry({String id, String poiId}) async {
    // TODO: implement deleteEntry
    return null;
  }

  @override
  Future<Either<Failure, Entry>> readEntry({String id}) async {
    // TODO: implement readEntry
    return null;
  }

  @override
  Future<Either<Failure, bool>> updateEntry({Entry entry, String poiId, String id})async  {
    // TODO: implement updateEntry
    return null;
  }
}
