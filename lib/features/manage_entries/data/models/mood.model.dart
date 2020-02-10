import 'package:baindo/features/manage_entries/domain/entities/mood.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mood.model.g.dart';
@JsonSerializable()
class MoodModel extends Mood{
  MoodModel(String mood, String description, int id) : super(mood, description, id);

  factory MoodModel.fromJson(Map<dynamic, dynamic> json) =>
    _$MoodModelFromJson(json);

  Map<dynamic, dynamic> toJson() => _$MoodModelToJson(this);
}