// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntryModel _$EntryModelFromJson(Map<String, dynamic> json) {
  return EntryModel(
    json['entry'] as String,
    json['mood'] as String,
    json['person_of_interest'] as String,
  );
}

Map<String, dynamic> _$EntryModelToJson(EntryModel instance) =>
    <String, dynamic>{
      'entry': instance.entry,
      'mood': instance.mood,
      'person_of_interest': instance.personOfInterest,
    };
