import 'package:bando/core/failures/failures.dart';
import 'package:bando/core/use_cases/use_cases.dart';
import 'package:bando/features/mood/domain/entities/mood.dart';
import 'package:bando/features/mood/domain/repositories/mood_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class GetMoods extends UseCase<List<Mood>, NoParams>{
  final MoodRepository moodRepository;

  GetMoods({@required this.moodRepository});
  @override
  Future<Either<Failure, List<Mood>>> call(NoParams params) {
    return moodRepository.getRemoteMoods();
  }

}

