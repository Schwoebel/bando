import 'package:baindo/features/manage_entries/domain/entities/entry.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entry_model.g.dart';

@JsonSerializable(anyMap: true)
class EntryModel extends Entry {
  EntryModel(createDate, entry, mood, String personOfInterest)
      : super(
          createDate,
          entry,
          mood,
          personOfInterest,
        );

  factory EntryModel.fromJson(String id, Map<dynamic, dynamic> json) {
    return _$EntryModelFromJson(json)..id = id;
  }

  factory EntryModel.fromEntry(Entry entry) {
    return EntryModel(
        entry.createDate, entry.entry, entry.mood, entry.personOfInterest);
  }

  Map<dynamic, dynamic> toJson() => _$EntryModelToJson(this);
}
