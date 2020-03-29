import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
part 'entry.g.dart';

@JsonSerializable(anyMap: true)
class Entry {
  @JsonKey(ignore: true)
  String id;
  @JsonKey(name: 'create_date')
  final int createDate;
  @JsonKey(nullable: false)
  final String title;
  final String text;
  final String author;
  @JsonKey(name: 'author_id')
  final String authorId;
  @JsonKey(name: 'meta_data')
  final Map<dynamic, dynamic> metaData;

  String get prettyDate {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(createDate);
    return dateTime.day.toString() +
        '-' +
        dateTime.month.toString() +
        '-' +
        dateTime.year.toString();
  }

  Entry( {@required this.authorId,
    @required this.createDate,
    @required this.title,
    @required this.metaData,
    @required this.text,
    @required this.author
  });
}
