// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dish.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dish _$DishFromJson(Map<String, dynamic> json) => Dish(
      (json['dishID'] as num?)?.toInt(),
      json['dishName'] as String?,
      json['dishDescription'] as String?,
      (json['dishCost'] as num?)?.toDouble(),
      (json['categoryID'] as num?)?.toInt(),
      json['dishImage'] as String?,
      json['speciality'] as bool?,
    );

Map<String, dynamic> _$DishToJson(Dish instance) => <String, dynamic>{
      'dishID': instance.dishID,
      'dishName': instance.dishName,
      'dishDescription': instance.dishDescription,
      'dishCost': instance.dishCost,
      'categoryID': instance.categoryID,
      'dishImage': instance.dishImage,
      'speciality': instance.speciality,
    };