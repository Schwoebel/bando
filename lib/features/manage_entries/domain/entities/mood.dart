import 'package:json_annotation/json_annotation.dart';

part 'mood.g.dart';
@JsonSerializable()
class Mood{
 String id;
 final String mood;
 final List<String> description;

  Mood(this.mood, this.description, this.id);
}