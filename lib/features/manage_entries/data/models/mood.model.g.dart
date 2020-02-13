// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoodModel _$MoodModelFromJson(Map<String, dynamic> json) {
  return MoodModel(
    json['mood'] as String,
    (json['description'] as List)?.map((e) => e as String)?.toList(),
    json['id'] as String,
  );
}

Map<String, dynamic> _$MoodModelToJson(MoodModel instance) => <String, dynamic>{
      'id': instance.id,
      'mood': instance.mood,
      'description': instance.description,
    };
