// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drinkUpdate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrinkUpdate _$DrinkUpdateFromJson(Map<String, dynamic> json) => DrinkUpdate(
      json['drinkName'] as String?,
      json['drinkDescription'] as String?,
      (json['drinkCost'] as num?)?.toDouble(),
      (json['drinkAlcoholPerc'] as num?)?.toDouble(),
      json['drinkImage'] as String?,
    );

Map<String, dynamic> _$DrinkUpdateToJson(DrinkUpdate instance) =>
    <String, dynamic>{
      'drinkName': instance.drinkName,
      'drinkDescription': instance.drinkDescription,
      'drinkCost': instance.drinkCost,
      'drinkAlcoholPerc': instance.drinkAlcoholPerc,
      'drinkImage': instance.drinkImage,
    };
