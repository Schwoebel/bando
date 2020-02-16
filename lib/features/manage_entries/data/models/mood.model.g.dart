// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoodModel _$MoodModelFromJson(Map<String, dynamic> json) {
  return MoodModel(
    json['mood'] as String,
    (json['description'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$MoodModelToJson(MoodModel instance) => <String, dynamic>{
      'mood': instance.mood,
      'description': instance.description,
    };
