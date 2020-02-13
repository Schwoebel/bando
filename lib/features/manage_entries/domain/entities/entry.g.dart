// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Entry _$EntryFromJson(Map<String, dynamic> json) {
  return Entry(
    json['id'] as String,
    json['createDate'] == null
        ? null
        : DateTime.parse(json['createDate'] as String),
    json['entry'] as String,
    json['mood'] as String,
    json['person_of_interest'] as String,
  );
}

Map<String, dynamic> _$EntryToJson(Entry instance) => <String, dynamic>{
      'id': instance.id,
      'createDate': instance.createDate?.toIso8601String(),
      'entry': instance.entry,
      'mood': instance.mood,
      'person_of_interest': instance.personOfInterest,
    };
