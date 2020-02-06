// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Entry _$EntryFromJson(Map<String, dynamic> json) {
  return Entry(
    json['entry'] as String,
    json['mood'] as String,
    json['person_of_interest'] as String,
  );
}

Map<String, dynamic> _$EntryToJson(Entry instance) => <String, dynamic>{
      'entry': instance.entry,
      'mood': instance.mood,
      'person_of_interest': instance.personOfInterest,
    };
