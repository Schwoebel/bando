import 'package:baindo/core/failures/failures.dart';
import 'package:baindo/features/manage_entries/domain/entities/entry.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

abstract class ManageEntriesRepository {
  Future<Either<Failure, bool>> createEntry({@required Entry entry});

  Future<Either<Failure, Entry>> readEntry({@required String id});

  Future<Either<Failure, bool>> updateEntry({@required Entry task, @required String id});

  Future<Either<Failure, bool>> deleteEntry({@required String id});

}
