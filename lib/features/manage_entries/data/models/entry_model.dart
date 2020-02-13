import 'package:baindo/features/manage_entries/domain/entities/entry.dart';
import 'package:baindo/features/manage_entries/domain/entities/mood.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entry_model.g.dart';

@JsonSerializable()
class EntryModel extends Entry {
  EntryModel(String id, DateTime createDate, String entry, String mood,
      String personOfInterest)
      : super(
          id,
          createDate,
          entry,
          mood,
          personOfInterest,
        );

  factory EntryModel.fromJson(String id, Map<dynamic, dynamic> json) {
    return _$EntryModelFromJson(json)..id = id;
  }

  Map<dynamic, dynamic> toJson() => _$EntryModelToJson(this);
}
