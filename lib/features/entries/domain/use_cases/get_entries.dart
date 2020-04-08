import 'package:bando/core/failures/failures.dart';
import 'package:bando/core/use_cases/use_cases.dart';
import 'package:bando/features/entries/domain/entities/entry.dart';
import 'package:bando/features/entries/domain/repositories/view_entries_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetEntries{
  ViewEntriesRepository viewEntriesRepository;

  GetEntries({@required this.viewEntriesRepository});

  Future<Either<Failure, Stream<List<Entry>>>> call(Params params) async {
    return await viewEntriesRepository.getEntries(personOfInterestId: params.personOfInterestId);
  }

}

class Params extends Equatable{

  final String personOfInterestId;

  Params(this.personOfInterestId);

  @override
  // TODO: implement props
  List<Object> get props => [personOfInterestId];

}