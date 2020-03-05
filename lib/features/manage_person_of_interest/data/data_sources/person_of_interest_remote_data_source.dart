import 'package:baindo/features/manage_person_of_interest/data/models/person_of_interest_model.dart';
import 'package:baindo/features/manage_person_of_interest/domain/entities/person_of_interest_entity.dart';
import 'package:baindo/features/view_entries/data/data_sources/view_entries_remote_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  PersonOfInterestRemoteDataSourceImpl(
      {@required this.firestore, @required this.firebaseAuth});

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
    FirebaseUser user = await firebaseAuth.currentUser();
    QuerySnapshot results = await firestore
        .collection(PERSON_OF_INTEREST)
        .where('users', arrayContains: user.uid)
        .getDocuments();
    print(results.documents[0].documentID);
    return results.documents
        .map(
          (DocumentSnapshot snapshot) => PersonOfInterestModel.fromJson(
            snapshot.documentID,
            snapshot.data,
          ),
        )
        .toList();
  }

  @override
  Future<PersonOfInterest> update({String id, PersonOfInterest person}) {
    // TODO: implement update
    return null;
  }
}
