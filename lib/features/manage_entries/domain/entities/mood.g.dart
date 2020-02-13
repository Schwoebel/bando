// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mood _$MoodFromJson(Map<String, dynamic> json) {
  return Mood(
    json['mood'] as String,
    (json['description'] as List)?.map((e) => e as String)?.toList(),
    json['id'] as String,
  );
}

Map<String, dynamic> _$MoodToJson(Mood instance) => <String, dynamic>{
      'id': instance.id,
      'mood': instance.mood,
      'description': instance.description,
    };
