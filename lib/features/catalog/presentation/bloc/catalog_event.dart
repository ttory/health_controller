import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CatalogEvent extends Equatable {
  const CatalogEvent();
}

class GetFood extends CatalogEvent {
  final String name;

  GetFood({@required this.name});

  @override
  List<Object> get props => [name];

  @override
  String toString() => 'GetFood';
}

class NavigationComplete extends CatalogEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'NavigationComplete';
}

class Loading extends CatalogEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'Loading';
}
