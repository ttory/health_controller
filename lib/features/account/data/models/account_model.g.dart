// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountModel _$AccountModelFromJson(Map<String, dynamic> json) {
  return AccountModel(
    name: json['name'] as String,
    birthday: json['birthday'] == null
        ? null
        : DateTime.parse(json['birthday'] as String),
    height: json['height'] as int,
    weight: json['weight'] as int,
    goalWeight: json['goalWeight'] as int,
    foodStatistic: (json['foodStatistic'] as List)
        ?.map((e) => (e as Map<String, dynamic>)?.map(
              (k, e) => MapEntry(
                  k,
                  (e as List)
                      ?.map((e) => e == null
                          ? null
                          : FoodModel.fromJson(e as Map<String, dynamic>))
                      ?.toList()),
            ))
        ?.toList(),
    weightStatistic: (json['weightStatistic'] as List)
        ?.map((e) => (e as Map<String, dynamic>)?.map(
              (k, e) => MapEntry(k, (e as num)?.toDouble()),
            ))
        ?.toList(),
  );
}

Map<String, dynamic> _$AccountModelToJson(AccountModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'birthday': instance.birthday?.toIso8601String(),
      'height': instance.height,
      'weight': instance.weight,
      'goalWeight': instance.goalWeight,
      'foodStatistic': instance.foodStatistic,
      'weightStatistic': instance.weightStatistic,
    };
