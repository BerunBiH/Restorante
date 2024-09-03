// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dishInsert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DishInsert _$DishInsertFromJson(Map<String, dynamic> json) => DishInsert(
      json['dishName'] as String?,
      json['dishDescription'] as String?,
      (json['dishCost'] as num?)?.toDouble(),
      (json['categoryId'] as num?)?.toInt(),
      json['dishImage'] as String?,
      json['speciality'] as bool?,
    );

Map<String, dynamic> _$DishInsertToJson(DishInsert instance) =>
    <String, dynamic>{
      'dishName': instance.dishName,
      'dishDescription': instance.dishDescription,
      'dishCost': instance.dishCost,
      'categoryId': instance.categoryId,
      'dishImage': instance.dishImage,
      'speciality': instance.speciality,
    };
