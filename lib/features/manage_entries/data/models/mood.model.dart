import 'package:baindo/features/manage_entries/domain/entities/mood.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mood.model.g.dart';
@JsonSerializable()
class MoodModel extends Mood{
  MoodModel(String mood, List<String> description) : super(mood, description);

  factory MoodModel.fromJson(String id, Map<dynamic, dynamic> json){
    return _$MoodModelFromJson(json)..id = id;
  }


  Map<dynamic, dynamic> toJson() => _$MoodModelToJson(this);
}