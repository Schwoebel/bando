import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;

  User({
    @required this.id,
    @required this.email,
    this.name,
  });

  factory User.fromFirebase(FirebaseUser firebaseUser) => User(
    id: firebaseUser.uid,
    email: firebaseUser.email,
    name: firebaseUser.displayName,
  );

  @override
  List<Object> get props => [this.id, this.email, this.name,];
}
