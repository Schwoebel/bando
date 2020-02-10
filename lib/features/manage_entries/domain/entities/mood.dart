import 'package:json_annotation/json_annotation.dart';

part 'mood.g.dart';
@JsonSerializable()
class Mood{
 final String mood;
 final String description;
 final int id;

  Mood(this.mood, this.description, this.id);
}