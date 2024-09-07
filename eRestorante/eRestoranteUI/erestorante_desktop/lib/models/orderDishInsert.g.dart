// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderDishInsert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDishInsert _$OrderDishInsertFromJson(Map<String, dynamic> json) =>
    OrderDishInsert(
      (json['orderQuantity'] as num?)?.toInt(),
      (json['orderId'] as num?)?.toInt(),
      (json['dishId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderDishInsertToJson(OrderDishInsert instance) =>
    <String, dynamic>{
      'orderQuantity': instance.orderQuantity,
      'orderId': instance.orderId,
      'dishId': instance.dishId,
    };
