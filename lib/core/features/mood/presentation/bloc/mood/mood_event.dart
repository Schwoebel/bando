part of 'mood_bloc.dart';

@immutable
abstract class MoodEvent {}


class GetMoodsEvent extends MoodEvent {}

class MoodSelected extends MoodEvent {
  final List<Mood> moods;

  MoodSelected(this.moods);
}
