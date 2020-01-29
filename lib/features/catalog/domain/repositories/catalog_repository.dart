import 'package:dartz/dartz.dart';

import '../../../../core/error/error.dart';
import '../../data/models/food_model.dart';

abstract class CatalogRepository {
  Future<Either<Failure, FoodModel>> getFoodsByName(String name);
}
