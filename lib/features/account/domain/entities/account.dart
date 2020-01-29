import 'package:equatable/equatable.dart';
import 'package:flutter_health_controller/features/catalog/data/models/food_model.dart';

import 'package:meta/meta.dart';

class Account extends Equatable {
  final String name;
  final DateTime birthday;
  final int height;
  final int weight;
  final int goalWeight;
  final List<Map<String, List<FoodModel>>> foodStatistic;
  final List<Map<String, double>> weightStatistic;

  Account({
    @required this.name,
    @required this.birthday,
    @required this.height,
    @required this.weight,
    @required this.goalWeight,
    this.foodStatistic,
    this.weightStatistic,
  });

  double get totalColories => foodStatistic.fold(0, (a, b) => a + b[DateTime.now().weekday.toString()].map((i) => i.colories).first);

  @override
  List<Object> get props => [
        name,
        birthday,
        height,
        weight,
        goalWeight,
        foodStatistic,
        weightStatistic,
      ];

  @override
  String toString() =>
      'Account { name: $name, birthday: $birthday, height: $height, weight: $weight, goalWeight: $goalWeight, foodStatistic: $foodStatistic, weightStatistic: $weightStatistic }';
}
