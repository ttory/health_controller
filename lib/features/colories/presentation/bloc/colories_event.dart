import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ColoriesEvent extends Equatable {
  const ColoriesEvent();
}

class CalculateColories extends ColoriesEvent {
  final int personHeight;
  final int personWeight;

  CalculateColories({@required this.personHeight, @required this.personWeight});

  @override
  List<Object> get props => [personHeight, personWeight];

  @override
  String toString() => 'CalculateColories { personHeight: $personHeight, personWeight: $personWeight }';
}
