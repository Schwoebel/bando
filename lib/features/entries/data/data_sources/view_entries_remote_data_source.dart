import 'package:bando/features/entries/data/models/entry_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

abstract class ViewEntriesRemoteDataSource {
  Stream<List<EntryModel>> getEntriesForPersonOfInterest({
    @required String personOfInterestId,
  });
}

const ENTRIES_COLLECTION_NAME = 'entries';
const PERSON_OF_INTEREST = 'person_of_interest';

class ViewEntriesRemoteDataSourceImpl extends ViewEntriesRemoteDataSource {
  Firestore firestore;

  ViewEntriesRemoteDataSourceImpl({@required this.firestore});

  @override
  Stream<List<EntryModel>> getEntriesForPersonOfInterest(
      {String personOfInterestId}) {
    Stream<QuerySnapshot> querySnapshot = firestore
        .collection(PERSON_OF_INTEREST)
        .document(personOfInterestId)
        .collection(ENTRIES_COLLECTION_NAME)
        .orderBy('create_date')
        .snapshots();
    return querySnapshot.map((QuerySnapshot snapshot) {
      return snapshot.documents
          .map((DocumentSnapshot element) =>
              EntryModel.fromJson(element.documentID, element.data))
          .toList();
    });
  }
}
