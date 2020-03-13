import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
part 'role.g.dart';
@JsonSerializable(anyMap: true)
class Role extends Equatable {
  @JsonKey(name: 'area_of_interest')
  final String areaOfInterest;
  @JsonKey(name: 'poi_id')
  final String poiId;
  @JsonKey(name: 'role_level')
  final int roleLevel;
  @JsonKey(name: 'role_name')
  final String roleName;

  Role(
    {@required this.areaOfInterest,
      @required this.poiId,
      @required this.roleLevel,
      @required this.roleName});

  @override
  // TODO: implement props
  List<Object> get props => [
    areaOfInterest,
    poiId,
    roleLevel,
    roleName,
  ];
  factory Role.fromJson(Map<String, dynamic> json) =>
    _$RoleFromJson(json);

  Map<dynamic, dynamic> toJson() => _$RoleToJson(this);
}