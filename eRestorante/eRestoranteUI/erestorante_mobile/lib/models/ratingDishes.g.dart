// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ratingDishes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingDishes _$RatingDishesFromJson(Map<String, dynamic> json) => RatingDishes(
      (json['ratingId'] as num?)?.toInt(),
      (json['dishId'] as num?)?.toInt(),
      (json['ratingNumber'] as num?)?.toInt(),
      json['ratingDate'] as String?,
    );

Map<String, dynamic> _$RatingDishesToJson(RatingDishes instance) =>
    <String, dynamic>{
      'ratingId': instance.ratingId,
      'dishId': instance.dishId,
      'ratingNumber': instance.ratingNumber,
      'ratingDate': instance.ratingDate,
    };
