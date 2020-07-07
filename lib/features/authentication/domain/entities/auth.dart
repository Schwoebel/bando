import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'user.dart';

class Auth extends Equatable {
  final User currentUser;
  final String code;
  final String message;

  Auth({
    @required this.currentUser,
    this.code,
    this.message,
  });

  List<Object> get props => [this.currentUser, this.code, this.message,];
}
