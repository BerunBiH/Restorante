// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderDishes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDishes _$OrderDishesFromJson(Map<String, dynamic> json) => OrderDishes(
      (json['orderDishId'] as num?)?.toInt(),
      (json['orderQuantity'] as num?)?.toInt(),
      (json['orderId'] as num?)?.toInt(),
      (json['dishId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderDishesToJson(OrderDishes instance) =>
    <String, dynamic>{
      'orderDishId': instance.orderDishId,
      'orderQuantity': instance.orderQuantity,
      'orderId': instance.orderId,
      'dishId': instance.dishId,
    };
