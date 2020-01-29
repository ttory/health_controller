// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodModel _$FoodModelFromJson(Map<String, dynamic> json) {
  return FoodModel(
    id: json['id'] as String,
    label: json['label'] as String,
    imageUrl: json['imageUrl'] as String,
    colories: (json['colories'] as num)?.toDouble(),
    category: json['category'] as String,
  );
}

Map<String, dynamic> _$FoodModelToJson(FoodModel instance) => <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'imageUrl': instance.imageUrl,
      'colories': instance.colories,
      'category': instance.category,
    };
