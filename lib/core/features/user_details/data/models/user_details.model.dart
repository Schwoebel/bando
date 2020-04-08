import 'package:bando/core/features/user_details/domain/entities/role.dart';
import 'package:bando/core/features/user_details/domain/entities/user_details.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'user_details.model.g.dart';

@JsonSerializable(anyMap: true)
class UserDetailsModel extends UserDetails {

  @override
  @JsonKey(toJson: _convertToJson)
  final List<Role> roles;

  UserDetailsModel({
    @required lastName,
    @required firstName,
    @required email,
    @required this.roles,
    @required authors,
  }) : super(
          lastName: lastName,
          firstName: firstName,
          email: email,
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

List<Map<dynamic, dynamic>> _convertToJson(List<Role> value){
  return value.map((Role f ) => f.toJson()).toList();
}
