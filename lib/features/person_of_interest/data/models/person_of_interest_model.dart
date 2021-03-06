import 'package:bando/features/person_of_interest/domain/entities/person_of_interest_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'person_of_interest_model.g.dart';

@JsonSerializable()
class PersonOfInterestModel extends PersonOfInterest {
  final String initials;

  PersonOfInterestModel({@required this.initials, id}) : super(id, initials);
  factory PersonOfInterestModel.fromJson(String id, Map<dynamic, dynamic> json) =>
    _$PersonOfInterestModelFromJson(json)..id=id;

  Map<dynamic, dynamic> toJson() => _$PersonOfInterestModelToJson(this);
}
