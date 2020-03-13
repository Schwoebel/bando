import 'package:baindo/core/features/user_details/domain/entities/role.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';


class UserDetails extends Equatable {
  final String email;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'people_of_interest')
  final List<dynamic> peopleOfInterest;
  final List<Role> roles;

  UserDetails({
    @required this.email,
    @required this.firstName,
    @required this.lastName,
    @required this.peopleOfInterest,
    @required this.roles,
  });

  @override
  List<Object> get props => [
        email,
        firstName,
        lastName,
        peopleOfInterest,
        roles,
      ];
}

