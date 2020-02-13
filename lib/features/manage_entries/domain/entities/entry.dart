import 'package:baindo/features/manage_entries/domain/entities/mood.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entry.g.dart';

@JsonSerializable()
class Entry {
  String id;
  final DateTime createDate;
  final String entry;
  final String mood;
  @JsonKey(name: 'person_of_interest')
  final String personOfInterest;

  Entry(this.id, this.createDate, this.entry, this.mood, this.personOfInterest);
}
