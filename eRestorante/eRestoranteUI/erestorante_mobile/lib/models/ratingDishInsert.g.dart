// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ratingDishInsert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingDishInsert _$RatingDishInsertFromJson(Map<String, dynamic> json) =>
    RatingDishInsert(
      (json['customerId'] as num?)?.toInt(),
      (json['dishId'] as num?)?.toInt(),
      (json['ratingNumber'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RatingDishInsertToJson(RatingDishInsert instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
      'dishId': instance.dishId,
      'ratingNumber': instance.ratingNumber,
    };
