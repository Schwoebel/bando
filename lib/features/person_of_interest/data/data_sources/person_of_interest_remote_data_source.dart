import 'package:bando/features/user_details/data/data_sources/user_details_local_data_source.dart';
import 'package:bando/features/user_details/data/data_sources/user_details_remote_data_source.dart';
import 'package:bando/features/user_details/domain/entities/role.dart';
import 'package:bando/features/user_details/domain/entities/user_details.dart';
import 'package:bando/features/person_of_interest/data/models/person_of_interest_model.dart';
import 'package:bando/features/person_of_interest/domain/entities/person_of_interest_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

abstract class PersonOfInterestRemoteDataSource {
  Future<PersonOfInterest> create({@required PersonOfInterest person});

  Future<PersonOfInterest> read({@required String id});

  Future<List<PersonOfInterest>> readAllAllowed();

  Future<PersonOfInterest> update(
      {@required String id, PersonOfInterest person});

  Future<bool> delete({@required String id});
}

class PersonOfInterestRemoteDataSourceImpl
    extends PersonOfInterestRemoteDataSource {
  final Firestore firestore;
  final FirebaseAuth firebaseAuth;
  final UserDetailsRemoteDataSource userDetailsRemoteDataSource;
  final UserDetailsLocalDataSource userDetailsLocalDataSource;

  PersonOfInterestRemoteDataSourceImpl({
    @required this.firestore,
    @required this.firebaseAuth,
    @required this.userDetailsRemoteDataSource,
    @required this.userDetailsLocalDataSource,
  });

  @override
  Future<PersonOfInterest> create({PersonOfInterest person}) {
    // TODO: implement create
    return null;
  }

  @override
  Future<bool> delete({String id}) {
    // TODO: implement delete
    return null;
  }

  @override
  Future<PersonOfInterest> read({String id}) {
    // TODO: implement read
    return null;
  }

  @override
  Future<List<PersonOfInterest>> readAllAllowed() async {
    UserDetails details = await userDetailsLocalDataSource.getUserDetails();
    if(details != null){
      List<Future<DocumentSnapshot>> snaps = details.roles.map((Role r) =>
        firestore.collection('person_of_interest').document(r.poiId).get()).toList();
      List<PersonOfInterest> pois =  await Future.wait(snaps)
        .then((List<DocumentSnapshot> onValue) => onValue
        .map(
          (DocumentSnapshot snap) => PersonOfInterestModel.fromJson(
          snap.documentID,
          snap.data,
        ),
      )
        .toList());
      return pois;
    } else {
      return [];
    }

  }

  @override
  Future<PersonOfInterest> update({String id, PersonOfInterest person}) {
    // TODO: implement update
    return null;
  }
}
