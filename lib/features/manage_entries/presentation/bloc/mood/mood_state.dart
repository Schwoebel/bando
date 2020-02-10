part of 'mood_bloc.dart';

@immutable
abstract class MoodState {}

class InitialMoodState extends MoodState {}

class HasMoodsState extends MoodState {
  final List<Mood> moods;

  HasMoodsState(this.moods);
}

class HasErrorMoodState extends MoodState {}