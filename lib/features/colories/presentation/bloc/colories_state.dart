import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ColoriesState extends Equatable {
  const ColoriesState();
}

class ColoriesUninitialized extends ColoriesState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ColoriesUninitialized';
}

class ColoriesError extends ColoriesState {
  final String message;

  ColoriesError({@required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'ColoriesError { message: $message }';
}

class ColoriesCalculated extends ColoriesState {
  final double colories;
  final String result;

  ColoriesCalculated({@required this.colories, @required this.result});

  @override
  List<Object> get props => [colories, result];

  @override
  String toString() => 'ColoriesCalculated { colories: $colories, result; $result }';
}
