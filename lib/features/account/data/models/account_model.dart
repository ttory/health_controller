import 'package:flutter_health_controller/features/catalog/data/models/food_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/account.dart';

part 'account_model.g.dart';

@JsonSerializable()
class AccountModel extends Account {
  AccountModel({
    @required String name,
    @required DateTime birthday,
    @required int height,
    @required int weight,
    @required int goalWeight,
    List<Map<String, List<FoodModel>>> foodStatistic,
    List<Map<String, double>> weightStatistic,
  }) : super(
          name: name,
          birthday: birthday,
          height: height,
          weight: weight,
          goalWeight: goalWeight,
          foodStatistic: foodStatistic,
          weightStatistic: weightStatistic,
        );

  factory AccountModel.fromJson(Map<String, dynamic> json) => _$AccountModelFromJson(json);
  Map<String, dynamic> toJson() => _$AccountModelToJson(this);

  bool contains(FoodModel food) => foodStatistic.any((i) => i[DateTime.now().weekday.toString()].any((i) => i.id == food.id));

  @override
  List<Object> get props => [name, birthday, height, weight, goalWeight, foodStatistic, weightStatistic];
}
