import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRemoteDataSource {
  Future<FirebaseUser> getCurrentUser();

  Future<AuthResult> createUser(String email, String password);

  Future<AuthResult> signIn(String email, String password);

  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  static const ROLES_COLLECTION_NAME = 'user_roles';
  final FirebaseAuth firebaseAuth;
  final SharedPreferences sharedPreferences;

  AuthRemoteDataSourceImpl(
    {@required this.firebaseAuth, @required this.sharedPreferences,});

  @override
  Future<FirebaseUser> getCurrentUser() async {
    return await firebaseAuth.currentUser();
  }

  @override
  Future<AuthResult> createUser(String email, String password) async {
    return await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password
    );
  }

  @override
  Future<AuthResult> signIn(String email, String password) async {
    try {
      return await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> signOut() async {
    await sharedPreferences.clear();
    return await firebaseAuth.signOut();
  }
}
