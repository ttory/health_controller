import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/food.dart';

part 'food_model.g.dart';

@JsonSerializable()
class FoodModel extends Food {
  FoodModel({
    @required String id,
    @required String label,
    @required String imageUrl,
    @required double colories,
    @required String category,
  }) : super(
          id: id,
          label: label,
          imageUrl: imageUrl,
          colories: colories,
          category: category,
        );

  factory FoodModel.fromJson(Map<String, dynamic> json) => _$FoodModelFromJson(json);
  Map<String, dynamic> toJson() => _$FoodModelToJson(this);

  @override
  List<Object> get props => [id, label, imageUrl, colories, category];
}
