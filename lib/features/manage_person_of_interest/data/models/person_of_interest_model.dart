import 'package:json_annotation/json_annotation.dart';
import 'package:baindo/features/manage_person_of_interest/domain/entities/person_of_interest_entity.dart';
import 'package:meta/meta.dart';

part 'person_of_interest_model.g.dart';

@JsonSerializable()
class PersonOfInterestModel extends PersonOfInterest {
  final String initials;
  final String id;

  PersonOfInterestModel({@required this.initials, @required this.id}) : super(id, initials);
  factory PersonOfInterestModel.fromJson(String id, Map<dynamic, dynamic> json) =>
    _$PersonOfInterestModelFromJson(json)..id;

  Map<dynamic, dynamic> toJson() => _$PersonOfInterestModelToJson(this);
}
