import 'package:baindo/features/manage_entries/domain/entities/entry.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entry_model.g.dart';

@JsonSerializable(anyMap: true)
class EntryModel extends Entry {
  EntryModel({createDate, text, title, metaData, author})
      : super(
            createDate: createDate,
            text: text,
            title: title,
            metaData: metaData,
            author: author);

  factory EntryModel.fromJson(String id, Map<dynamic, dynamic> json) {
    return _$EntryModelFromJson(json)..id = id;
  }

  factory EntryModel.fromEntry(Entry entry) {
    return EntryModel(
        createDate: entry.createDate,
        text: entry.text,
        author: entry.author,
        title: entry.title,
        metaData: entry.metaData);
  }

  Map<dynamic, dynamic> toJson() => _$EntryModelToJson(this);
}
