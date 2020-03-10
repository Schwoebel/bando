import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
part 'role.g.dart';
@JsonSerializable()
class Role extends Equatable {
  @JsonKey(name: 'area_of_interest')
  final String areaOfInterest;
  @JsonKey(name: 'role_id')
  final String roleId;
  @JsonKey(name: 'role_level')
  final String roleLevel;
  @JsonKey(name: 'role_name')
  final String roleName;

  Role(
    {@required this.areaOfInterest,
      @required this.roleId,
      @required this.roleLevel,
      @required this.roleName});

  @override
  // TODO: implement props
  List<Object> get props => [
    areaOfInterest,
    roleId,
    roleLevel,
    roleName,
  ];
  factory Role.fromJson(Map<String, dynamic> json) =>
    _$RoleFromJson(json);

  Map<dynamic, dynamic> toJson() => _$RoleToJson(this);
}