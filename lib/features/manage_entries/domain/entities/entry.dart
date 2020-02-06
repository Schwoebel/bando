import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entry.g.dart';

@JsonSerializable()
class Entry {
 // @JsonKey(name: 'create_date', fromJson: firestoreTimeStampFromJson)
 // final dynamic createDate;
  final String entry;
  final String mood;
  @JsonKey(name: 'person_of_interest')
  final String personOfInterest;

  Entry(/*this.createDate,*/ this.entry, this.mood, this.personOfInterest);
}

Timestamp firestoreTimeStampFromJson(Timestamp value) {
  return value;
}
