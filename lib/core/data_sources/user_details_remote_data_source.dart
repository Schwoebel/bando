import 'package:baindo/core/failures/failures.dart';
import 'package:baindo/core/features/user_details/data/models/user_details.model.dart';
import 'package:baindo/core/features/user_details/domain/entities/user_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

abstract class UserDetailsRemoteDataSource{
  Future<UserDetailsModel> getUserDetails();
  Future<bool> updateUserDetails();
}

class UserDetailsRemoteDataSourceImpl implements UserDetailsRemoteDataSource{
    final FirebaseAuth firebaseAuth;
    final Firestore fireStore;

  UserDetailsRemoteDataSourceImpl({@required this.firebaseAuth, @required this.fireStore});

  @override
  Future<UserDetailsModel> getUserDetails() async {
    try{
      FirebaseUser user = await firebaseAuth.currentUser();
      DocumentSnapshot snapshot = await fireStore.document('/user_details/' + user.uid).get();
      return UserDetailsModel.fromJson(snapshot.data);
    } on PlatformException{
      throw NetworkFailure();
    }
  }

  @override
  Future<bool> updateUserDetails() {
    // TODO: implement updateUserDetails
    return null;
  }
}

