import 'package:baindo/core/features/user_details/domain/entities/user_details.dart';
import 'package:baindo/features/entries/domain/entities/entry.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entry_model.g.dart';

@JsonSerializable(anyMap: true)
class EntryModel extends Entry {
  EntryModel({authorId, createDate, text, title, metaData, author})
      : super(
            authorId: authorId,
            createDate: createDate,
            text: text,
            title: title,
            metaData: metaData,
            author: author);

  factory EntryModel.fromJson(String id, Map<dynamic, dynamic> json) {
    return _$EntryModelFromJson(json)..id = id;
  }

  factory EntryModel.fromEntry(Entry entry, UserDetails userDetails) {
    return EntryModel(
        createDate: entry.createDate,
        text: entry.text,
        author: entry.author.isNotEmpty
            ? entry.author
            : "${userDetails.firstName} ${userDetails.lastName}",
        title: entry.title,
        metaData: entry.metaData);
  }

  Map<dynamic, dynamic> toJson() => _$EntryModelToJson(this);
}
