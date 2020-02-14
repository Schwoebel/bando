import 'package:json_annotation/json_annotation.dart';

part 'person_of_interest_entity.g.dart';

@JsonSerializable()
class PersonOfInterest{
  final String id;
  final String initials;

  PersonOfInterest(this.id, this.initials);
}