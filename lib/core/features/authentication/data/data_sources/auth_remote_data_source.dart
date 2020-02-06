import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

abstract class AuthRemoteDataSource {
  Future<FirebaseUser> getCurrentUser();
  Future<AuthResult> createUser(String email, String password);
  Future<AuthResult> signIn(String email, String password);
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  static const ROLES_COLLECTION_NAME = 'user_roles';
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl({@required this.firebaseAuth});

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
    return await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password
    );
  }

  @override
  Future<void> signOut() async {
    return await firebaseAuth.signOut();
  }
}
