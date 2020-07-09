import 'package:bando/features/user_details/data/data_sources/user_details_local_data_source.dart';
import 'package:bando/core/failures/failures.dart';
import 'package:bando/features/entries/data/data_sources/entry_remote_source.dart';
import 'package:bando/features/entries/data/models/entry_model.dart';
import 'package:bando/features/entries/domain/entities/entry.dart';
import 'package:bando/features/entries/domain/repositories/manage_entries_repository.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';

class ManageEntriesRepositoryImpl extends ManageEntriesRepository {
  final EntryRemoteSource entryRemoteSource;
  final UserDetailsLocalDataSource userDetailsLocalDataSource;

  ManageEntriesRepositoryImpl(
      {@required this.entryRemoteSource,
      @required this.userDetailsLocalDataSource});

  @override
  Future<Either<Failure, Entry>> createEntry({Entry entry, String poiId}) async {
    try {
      EntryModel model = EntryModel.fromEntry(
        entry,
        await userDetailsLocalDataSource.getUserDetails(),
      );
      await entryRemoteSource.createEntry(
          entry: model, personOfInterestId: poiId);
      return Right(model);
    } catch (e) {
      return Left(NetworkFailure());
    }
    return null;
  }

  @override
  Future<Either<Failure, bool>> deleteEntry({String id, String poiId}) async {
    entryRemoteSource.deleteEntry(id: id, personOfInterestId: poiId);
    return null;
  }

  @override
  Future<Either<Failure, Entry>> readEntry({String id}) async {
    // TODO: implement readEntry
    return null;
  }

  @override
  Future<Either<Failure, Entry>> updateEntry(
      {Entry entry, String poiId, String id}) async {
    // TODO: implement updateEntry
    return null;
  }
}
