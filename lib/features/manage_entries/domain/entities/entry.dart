import 'package:json_annotation/json_annotation.dart';

part 'entry.g.dart';

@JsonSerializable(anyMap: true)
class Entry {
  @JsonKey(ignore: true)
  String id;
  @JsonKey(name: 'create_date')
  int createDate;
  String entry;
  String mood;
  @JsonKey(name: 'person_of_interest')
  String personOfInterest;

  String get prettyDate {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(createDate);
    return dateTime.day.toString() +
        '-' +
        dateTime.month.toString() +
        '-' +
        dateTime.year.toString();
  }

  Entry(this.createDate, this.entry, this.mood, this.personOfInterest);
}
