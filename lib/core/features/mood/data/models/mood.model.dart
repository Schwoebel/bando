import 'dart:convert';

import 'package:bando/core/features/mood/domain/entities/mood.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mood.model.g.dart';
@JsonSerializable()
class MoodModel extends Mood{
  MoodModel(String mood, String id) : super(mood, id);

  factory MoodModel.fromJson(Map<String, dynamic> json){
    return _$MoodModelFromJson(json);
  }

  factory MoodModel.fromLocalStorageJson(Map<dynamic, dynamic> json){
    return _$MoodModelFromJson(json);
  }

  factory MoodModel.fromMood(String id, String mood){
    return MoodModel.fromJson({'id': id, 'mood': mood});
  }

  Map<dynamic, dynamic> toJson() => _$MoodModelToJson(this);
}