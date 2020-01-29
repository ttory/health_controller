import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/error.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/food_model.dart';
import '../entities/food.dart';
import '../repositories/catalog_repository.dart';

class GetFoodByName implements UseCase<Food, Params> {
  final CatalogRepository repository;

  GetFoodByName(this.repository);

  @override
  Future<Either<Failure, FoodModel>> call(Params params) async {
    return await repository.getFoodsByName(params.name);
  }
}

class Params extends Equatable {
  final String name;

  Params({@required this.name});

  @override
  List<Object> get props => [name];
}
