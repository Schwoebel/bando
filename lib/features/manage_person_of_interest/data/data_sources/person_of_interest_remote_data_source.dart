import 'package:baindo/features/manage_person_of_interest/domain/entities/person_of_interest_entity.dart';
import 'package:meta/meta.dart';
abstract class PersonOfInterestRemoteDataSource {
  Future<PersonOfInterest> create({@required PersonOfInterest person});

  Future<PersonOfInterest> read({@required String id});

  Future<List<PersonOfInterest>> readAllAllowed();

  Future<PersonOfInterest> update({@required String id, PersonOfInterest person});

  Future<bool> delete({@required String id});
}
