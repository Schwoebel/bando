import 'package:baindo/core/failures/failures.dart';
import 'package:baindo/features/mood/domain/entities/mood.dart';
import 'package:dartz/dartz.dart';

abstract class MoodRepository{
  Future<Either<Failure, List<Mood>>> getRemoteMoods();
}