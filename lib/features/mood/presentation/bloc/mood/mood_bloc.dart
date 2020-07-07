import 'dart:async';
import 'package:bando/core/failures/failures.dart';
import 'package:bando/core/use_cases/use_cases.dart';
import 'package:bando/features/mood/domain/entities/mood.dart';
import 'package:bando/features/mood/domain/use_cases/get_moods.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'mood_event.dart';

part 'mood_state.dart';

class MoodBloc extends Bloc<MoodEvent, MoodState> {
  final GetMoods moods;

  MoodBloc({
    @required this.moods,
  }) : super(InitialMoodState());


  @override
  Stream<MoodState> mapEventToState(MoodEvent event) async* {
    if (event is GetMoodsEvent) {
      Either<Failure, List<Mood>> getMoodAttempt = await moods(NoParams());
      yield* _failureOrMoodList(getMoodAttempt);
    } else if (event is MoodSelected) {
      yield HasMoodsState(event.moods);
    }
  }

  Stream<MoodState> _failureOrMoodList(
      Either<Failure, List<Mood>> attempt) async* {
    yield attempt.fold(
      (failure) => HasErrorMoodState(),
      (success) => HasMoodsState(success),
    );
  }
}
