import 'package:bando/core/failures/failures.dart';
import 'package:bando/features/entries/domain/entities/entry.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

abstract class ManageEntriesRepository {
  Future<Either<Failure, Entry>> createEntry({@required Entry entry, @required String poiId});

  Future<Either<Failure, Entry>> readEntry({@required String id});

  Future<Either<Failure, Entry>> updateEntry({@required Entry entry, @required String poiId, @required String id});

  Future<Either<Failure, bool>> deleteEntry({@required String id, @required String poiId});

}
