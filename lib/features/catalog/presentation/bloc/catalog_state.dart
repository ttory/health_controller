import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/models/food_model.dart';
import '../../domain/entities/food.dart';

abstract class CatalogState extends Equatable {
  const CatalogState();
}

class InitialCatalogState extends CatalogState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'InitialCatalogState';
}

class CatalogError extends CatalogState {
  final String message;

  CatalogError({@required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'CatalogError { message: $message }';
}

class CatalogLoading extends CatalogState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'CatalogLoading';
}

class CatalogLoaded extends CatalogState {
  final FoodModel foodData;

  CatalogLoaded({@required this.foodData});

  CatalogLoaded copyWith({Food foodData}) {
    return CatalogLoaded(
      foodData: foodData ?? this.foodData,
    );
  }

  @override
  List<Object> get props => [foodData];

  @override
  String toString() => 'CatalogLoaded { foodData: $foodData }';
}
