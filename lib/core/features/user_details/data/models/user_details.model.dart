import 'package:baindo/core/features/user_details/domain/entities/role.dart';
import 'package:baindo/core/features/user_details/domain/entities/user_details.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'user_details.model.g.dart';

@JsonSerializable(anyMap: true)
class UserDetailsModel extends UserDetails {
  final List<Role> roles;

  UserDetailsModel({
    @required lastName,
    @required firstName,
    @required email,
    @required peopleOfInterest,
    @required this.roles,
    @required authors,
  }) : super(
          lastName: lastName,
          firstName: firstName,
          email: email,
          peopleOfInterest: peopleOfInterest,
          roles: roles,
          authors: authors,
        );

  factory UserDetailsModel.fromJson(Map<dynamic, dynamic> json) =>
      _$UserDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsModelToJson(this);
}

List<Role> _convertToRole(dynamic role) {
  List<Role> roleList = role.map((f) => Role.fromJson(f)).toList();
  return roleList;
}
