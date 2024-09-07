// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderDrinks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDrinks _$OrderDrinksFromJson(Map<String, dynamic> json) => OrderDrinks(
      (json['orderDrinkId'] as num?)?.toInt(),
      (json['orderQuantity'] as num?)?.toInt(),
      (json['orderId'] as num?)?.toInt(),
      (json['drinkId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderDrinksToJson(OrderDrinks instance) =>
    <String, dynamic>{
      'orderDrinkId': instance.orderDrinkId,
      'orderQuantity': instance.orderQuantity,
      'orderId': instance.orderId,
      'drinkId': instance.drinkId,
    };
