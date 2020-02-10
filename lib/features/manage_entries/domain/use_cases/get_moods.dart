import 'package:baindo/core/failures/failures.dart';
import 'package:baindo/core/use_cases/use_cases.dart';
import 'package:baindo/features/manage_entries/domain/entities/mood.dart';
import 'package:baindo/features/manage_entries/domain/repositories/mood_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class GetMoods extends UseCase<List<Mood>, NoParams>{
  final MoodRepository moodRepository;

  GetMoods({@required this.moodRepository});
  @override
  Future<Either<Failure, List<Mood>>> call(NoParams params) {
    return moodRepository.getRemoteMoods();
  }

}

