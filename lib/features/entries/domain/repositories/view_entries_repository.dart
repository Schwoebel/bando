import 'package:bando/core/failures/failures.dart';
import 'package:bando/features/entries/domain/entities/entry.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

abstract class ViewEntriesRepository{
  Future<Either<Failure, List<Entry>>> getEntries({@required String personOfInterestId});
}