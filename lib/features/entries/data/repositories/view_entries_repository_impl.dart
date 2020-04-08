import 'package:bando/core/failures/exceptions.dart';
import 'package:bando/core/failures/failures.dart';
import 'package:bando/core/network/network_info.dart';
import 'package:bando/features/entries/data/models/entry_model.dart';
import 'package:bando/features/entries/domain/entities/entry.dart';
import 'package:bando/features/entries/data/data_sources/view_entries_local_data_source.dart';
import 'package:bando/features/entries/data/data_sources/view_entries_remote_data_source.dart';
import 'package:bando/features/entries/domain/repositories/view_entries_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class ViewEntriesRepositoryImpl extends ViewEntriesRepository {
  final ViewEntriesRemoteDataSource viewEntriesRemoteDataSource;
  final ViewEntriesLocalDataSource viewEntriesLocalDataSource;
  final NetworkInfo networkInfo;

  ViewEntriesRepositoryImpl({
    @required this.viewEntriesRemoteDataSource,
    @required this.viewEntriesLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Entry>>> getEntries({
    @required String personOfInterestId,
  }) async {
    print(personOfInterestId);
    if (await networkInfo.isConnected) {
      try {
        final List<EntryModel> entriesList =
            await viewEntriesRemoteDataSource.getEntriesForPersonOfInterest(
                personOfInterestId: personOfInterestId);
        viewEntriesLocalDataSource.cacheEntries(
          entries: entriesList,
        );
        return Right(entriesList);
      } catch(e) {
        print(e);
        return Left(ServerFailure());
      }
       } else {
      try {
        final localTrivia =
            await viewEntriesLocalDataSource.getEntriesFromLocalDataSource();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
