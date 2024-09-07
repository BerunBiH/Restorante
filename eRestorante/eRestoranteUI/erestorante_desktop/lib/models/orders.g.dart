// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      (json['ordersId'] as num?)?.toInt(),
      (json['orderNumber'] as num?)?.toInt(),
      json['orderDate'] as String?,
      (json['orderStatus'] as num?)?.toInt(),
      (json['orderNullified'] as num?)?.toInt(),
      (json['customerId'] as num?)?.toInt(),
      (json['orderDishes'] as List<dynamic>?)
          ?.map((e) => OrderDishes.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['orderDrinks'] as List<dynamic>?)
          ?.map((e) => OrderDrinks.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'ordersId': instance.ordersId,
      'orderNumber': instance.orderNumber,
      'orderDate': instance.orderDate,
      'orderStatus': instance.orderStatus,
      'orderNullified': instance.orderNullified,
      'customerId': instance.customerId,
      'orderDishes': instance.orderDishes?.map((e) => e.toJson()).toList(),
      'orderDrinks': instance.orderDrinks?.map((e) => e.toJson()).toList(),
    };
