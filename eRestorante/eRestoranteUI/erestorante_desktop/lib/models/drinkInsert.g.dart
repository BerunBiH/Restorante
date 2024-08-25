// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drinkInsert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrinkInsert _$DrinkInsertFromJson(Map<String, dynamic> json) => DrinkInsert(
      json['drinkName'] as String?,
      json['drinkDescription'] as String?,
      (json['drinkCost'] as num?)?.toDouble(),
      (json['drinkAlcoholPerc'] as num?)?.toDouble(),
      json['drinkImage'] as String?,
      (json['categoryId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DrinkInsertToJson(DrinkInsert instance) =>
    <String, dynamic>{
      'drinkName': instance.drinkName,
      'drinkDescription': instance.drinkDescription,
      'drinkCost': instance.drinkCost,
      'drinkAlcoholPerc': instance.drinkAlcoholPerc,
      'drinkImage': instance.drinkImage,
      'categoryId': instance.categoryId,
    };
