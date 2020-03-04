import 'package:baindo/features/manage_entries/data/models/entry_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

abstract class ViewEntriesRemoteDataSource {
  Future<List<EntryModel>> getEntriesForPersonOfInterest({
    @required String personOfInterestId,
  });
}

const ENTRIES_COLLECTION_NAME = 'entries';
const PERSON_OF_INTEREST = 'person_of_interest';

class ViewEntriesRemoteDataSourceImpl extends ViewEntriesRemoteDataSource {
  Firestore firestore;

  ViewEntriesRemoteDataSourceImpl({@required this.firestore});

  @override
  Future<List<EntryModel>> getEntriesForPersonOfInterest(
      {String personOfInterestId}) async {
    QuerySnapshot querySnapshot = await firestore
        .collection(ENTRIES_COLLECTION_NAME).orderBy('create_date')
        .where(PERSON_OF_INTEREST, isEqualTo: personOfInterestId)
        .getDocuments();
    return querySnapshot.documents
        .map((element) => EntryModel.fromJson(element.documentID, element.data))
        .toList().reversed.toList();
  }
}
