// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drink.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Drink _$DrinkFromJson(Map<String, dynamic> json) => Drink(
      (json['drinkId'] as num?)?.toInt(),
      json['drinkName'] as String?,
      json['drinkDescription'] as String?,
      (json['drinkCost'] as num?)?.toDouble(),
      (json['drinkAlcoholPerc'] as num?)?.toInt(),
      json['drinkImage'] as String?,
      (json['categoryId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DrinkToJson(Drink instance) => <String, dynamic>{
      'drinkId': instance.drinkId,
      'drinkName': instance.drinkName,
      'drinkDescription': instance.drinkDescription,
      'drinkCost': instance.drinkCost,
      'drinkAlcoholPerc': instance.drinkAlcoholPerc,
      'drinkImage': instance.drinkImage,
      'categoryId': instance.categoryId,
    };
