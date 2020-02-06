import 'package:baindo/features/manage_entries/domain/entities/entry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entry_model.g.dart';

@JsonSerializable()
class EntryModel extends Entry {
  EntryModel(
      /*Timestamp createDate,*/ String entry, String mood, String personOfInterest)
      : super(/*createDate,*/ entry, mood, personOfInterest);

  factory EntryModel.fromJson(Map<dynamic, dynamic> json) =>
    _$EntryModelFromJson(json);

  Map<dynamic, dynamic> toJson() => _$EntryModelToJson(this);
}
