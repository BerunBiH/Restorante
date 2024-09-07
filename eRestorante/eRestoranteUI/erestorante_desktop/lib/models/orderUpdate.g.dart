// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderUpdate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderUpdate _$OrderUpdateFromJson(Map<String, dynamic> json) => OrderUpdate(
      (json['orderNullified'] as num?)?.toInt(),
      (json['orderStatus'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderUpdateToJson(OrderUpdate instance) =>
    <String, dynamic>{
      'orderStatus': instance.orderStatus,
      'orderNullified': instance.orderNullified,
    };
