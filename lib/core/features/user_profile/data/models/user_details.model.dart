import 'package:baindo/core/features/user_profile/domain/entities/user_details.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'user_details.model.g.dart';
@JsonSerializable()
class UserDetailsModel extends UserDetails {
  UserDetailsModel({
    @required lastName,
    @required firstName,
    @required email,
    @required peopleOfInterest,
    @required roles,
  }) : super(
          lastName: lastName,
          firstName: firstName,
          email: email,
          peopleOfInterest: peopleOfInterest,
          roles: roles,
        );
  factory UserDetailsModel.fromJson(Map<String, dynamic> json) =>
    _$UserDetailsModelFromJson(json);

  Map<dynamic, dynamic> toJson() => _$UserDetailsModelToJson(this);
}
