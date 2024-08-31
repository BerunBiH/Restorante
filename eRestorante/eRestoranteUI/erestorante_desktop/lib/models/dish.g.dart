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
      (json['categoryId'] as num?)?.toInt(),
      json['dishImage'] as String?,
      json['speciality'] as bool?,
      (json['CommentDishes'] as List<dynamic>?)
          ?.map((e) => CommentDish.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['ratingDishes'] as List<dynamic>?)
          ?.map((e) => RatingDishes.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['orderDishes'] as List<dynamic>?)
          ?.map((e) => OrderDishes.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DishToJson(Dish instance) => <String, dynamic>{
      'dishID': instance.dishID,
      'dishName': instance.dishName,
      'dishDescription': instance.dishDescription,
      'dishCost': instance.dishCost,
      'categoryId': instance.categoryId,
      'dishImage': instance.dishImage,
      'speciality': instance.speciality,
      'CommentDishes': instance.CommentDishes?.map((e) => e.toJson()).toList(),
      'orderDishes': instance.orderDishes?.map((e) => e.toJson()).toList(),
      'ratingDishes': instance.ratingDishes?.map((e) => e.toJson()).toList(),
    };
