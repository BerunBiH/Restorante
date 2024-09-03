// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dishUpdate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DishUpdate _$DishUpdateFromJson(Map<String, dynamic> json) => DishUpdate(
      json['dishName'] as String?,
      json['dishDescription'] as String?,
      (json['dishCost'] as num?)?.toDouble(),
      json['dishImage'] as String?,
      json['speciality'] as bool?,
    );

Map<String, dynamic> _$DishUpdateToJson(DishUpdate instance) =>
    <String, dynamic>{
      'dishName': instance.dishName,
      'dishDescription': instance.dishDescription,
      'dishCost': instance.dishCost,
      'dishImage': instance.dishImage,
      'speciality': instance.speciality,
    };
