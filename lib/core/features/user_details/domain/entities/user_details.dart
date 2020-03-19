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
  final List<Role> roles;
  final List<dynamic> authors;

  UserDetails(
      {@required this.email,
      @required this.firstName,
      @required this.lastName,
      @required this.roles,
      @required this.authors});

  UserDetails copyWith({String email, String firstName, String lastName, List<Role> roles, List<dynamic> authors}) {
    return UserDetails(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      roles: roles ?? this.roles,
      authors: authors ?? this.authors,
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'roles': roles,
      'authors': authors,
    };
  }

  @override
  List<Object> get props => [
        email,
        firstName,
        lastName,
        roles,
        authors,
      ];
}
