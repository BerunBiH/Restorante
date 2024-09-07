// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderDrinkInsert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDrinkInsert _$OrderDrinkInsertFromJson(Map<String, dynamic> json) =>
    OrderDrinkInsert(
      (json['orderQuantity'] as num?)?.toInt(),
      (json['orderId'] as num?)?.toInt(),
      (json['drinkId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderDrinkInsertToJson(OrderDrinkInsert instance) =>
    <String, dynamic>{
      'orderQuantity': instance.orderQuantity,
      'orderId': instance.orderId,
      'drinkId': instance.drinkId,
    };
