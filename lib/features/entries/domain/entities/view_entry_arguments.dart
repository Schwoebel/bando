import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
class ViewEntriesArgs extends Equatable{
  final String id;

  ViewEntriesArgs({@required this.id});

  @override
  // TODO: implement props
  List<Object> get props => [id];
}